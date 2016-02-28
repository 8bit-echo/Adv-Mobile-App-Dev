//
//  TableTableViewController.swift
//  To Do List
//
//  Created by Matt Dickey on 2/23/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    var items = [ToDoItem]()
    

    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        if segue.identifier == "doneSegue"{
            let source = segue.sourceViewController as! AddNewViewController
            if let newItem = source.addedItem{
                items.append(newItem)
                tableView.reloadData()
                addNotification(newItem)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList", name: "ListShouldRefresh", object: nil)
 
        
    }
    
    func refreshList(){
        tableView.reloadData()
        self.setBadgeNumber()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    //---------- Table view stuff ----------------//
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = items[indexPath.row].name
        
        let dateformatter = NSDateFormatter(); dateformatter.dateFormat = "MMM dd, yyyy HH:mm"
        let date = items[indexPath.row].reminderDate
        cell.detailTextLabel?.text = dateformatter.stringFromDate(date)
        
        
        if items[indexPath.row].overDue(){
            cell.detailTextLabel?.textColor = UIColor.redColor()
        }else{
            cell.detailTextLabel?.textColor = UIColor.blackColor()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            removeNotification(items[indexPath.row])
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.setBadgeNumber()
        }
        
    }

    
    //----------- Custom Methods ----------------//

    func addNotification(item: ToDoItem){
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        if settings?.types.rawValue == 0 {
            print("notifications not enabled")
        } else {
            let notification = UILocalNotification()
            notification.fireDate = item.reminderDate
            notification.alertBody = item.name
            notification.alertAction = "open"
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.userInfo = ["title": item.name, "UUID": item.id]
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            self.setBadgeNumber()
        }
    }
    
    func removeNotification(item : ToDoItem){
        
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! as[UILocalNotification]{
            if notification.userInfo!["UUID"] as! String == item.id{
                //cancel notification
                UIApplication.sharedApplication().cancelLocalNotification(notification)
            }
        }
    }
    
    func setBadgeNumber(){
        var badgeNumber = 0
        for item in items{
            if item.overDue() {
                badgeNumber++
            }
        }
        UIApplication.sharedApplication().applicationIconBadgeNumber = badgeNumber
    }
    
    
}