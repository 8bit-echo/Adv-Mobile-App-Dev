//
//  MasterListTableViewController.swift
//  Do Date
//
//  Created by Matt Dickey on 2/14/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit
import RealmSwift

class MasterListTableViewController: UITableViewController {
    
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        readAndUpdate()
    }
    
    // Establish a connection with the Realm Database object
    let uiRealm = try! Realm()
    
    //Load the Results of the fetch into the UI
    var assignmentList : Results<Assignment>!
    
    //Method reloads the database
    func readAndUpdate(){
        assignmentList = uiRealm.objects(Assignment)
        self.tableView.setEditing(false, animated: true)
        self.tableView.reloadData()
        
        
        //Attach a notification to each assignment
        for task in assignmentList{
            addNotification(task)
            print("notification added for \(task.name). Will alert user at the beginning of the day on \(task.dueDate)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readAndUpdate()
    }
    
    func viewWillAppear() {
        readAndUpdate()
    }
    
    
    // Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignmentList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath)
        
        let list = assignmentList[indexPath.row]
        cell.textLabel?.text = list.name
        cell.detailTextLabel?.text = list.subject
        
        if assignmentList[indexPath.row].isOverDue(){
            cell.textLabel?.textColor = UIColor.redColor()
        }else{
            cell.textLabel?.textColor = UIColor.blackColor()
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            try! uiRealm.write({ () -> Void in
                uiRealm.delete(assignmentList[indexPath.row])
            })
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
// ======= NOTE: THIS METHOD INCLUDES CODE FOR TESTING NOTIFICATIONS =========== //
    func addNotification(item: Assignment){
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        if settings?.types.rawValue == 0 {
            print("notifications not enabled")
        } else {
            let notification = UILocalNotification()
            //When task is created it is not due until Midnight. Notification should alert the user of due date at the beginning of the day. EOD = End of Day
            let EOD = item.dueDate
            let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            
            //fire the notification at the beginning of the Assignment's duedate
            let startOfDay = cal.startOfDayForDate(EOD)
            notification.fireDate = startOfDay
            
            // ======= AILEEN ! UNCOMMENT THE ABOVE LINES AND USE THE 2 LINES BELOW TO TEST NOTIFICATIONS ================= //
            
            //let fireNow = cal.dateBySettingHour(<#T##h: Int##Int#>, minute: <#T##Int#>, second: <#T##Int#>, ofDate: EOD, options: NSCalendarOptions())
            //notification.fireDate = fireNow
            
            
            notification.alertBody = "\(item.name) is due today!"
            notification.alertAction = "open"
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
        /*
        // Override to support conditional editing of the table view.
        override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
        }
        */
    
        /*
        // Override to support rearranging the table view.
        override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        }
        */
        
        /*
        // Override to support conditional rearranging of the table view.
        override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
        }
        */
        
        /*
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }
        */

    
}