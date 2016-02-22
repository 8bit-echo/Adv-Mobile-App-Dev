//
//  MasterViewController.swift
//  DC Comics
//
//  Created by Matt Dickey on 2/22/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    
    var detailVC: DetailViewController? = nil
    var heroes = [[String : String]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("DCuniverse", ofType: "plist")
        let alldata = NSDictionary(contentsOfFile: path!) as! [String : [[String:String]]]
        if alldata.isEmpty != true{
            heroes = Array(alldata["heroes"]!)
        }
        

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailVC = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let hero = heroes[indexPath.row]
                let url = hero["url"]! as String
                let name = hero["name"]! as String
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = url
                controller.title = name
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }else{
            print("segueIdentifier did not match")
        }
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        let hero = heroes[indexPath.row]
        cell.textLabel?.text = hero["name"]! as String

        return cell
    }


}
