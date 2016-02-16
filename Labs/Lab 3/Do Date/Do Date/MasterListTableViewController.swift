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
        
        print(assignmentList) //debugging statement
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        readAndUpdate()

    }
    
    func viewWillAppear() {
        readAndUpdate()
    }


    // MARK: - Table view data source

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
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
