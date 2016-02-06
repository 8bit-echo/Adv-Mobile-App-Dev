

import UIKit

class DoDateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var allAssignments : [String : [String]]!
    var classes : [String]!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchController : UISearchController!
    
     
    
   @IBAction func unwindSegue(segue: UIStoryboardSegue){}
    
    
    //Required methods for UITableViewDataSource
    //Number of rows in the section
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letter = classes[section]
        let classesection = allAssignments[letter]! as [String]
        return classesection.count
    }
    
    // Displays table view cells
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = indexPath.section
        let letter = classes[section]
        let wordsSection = allAssignments[letter]! as [String]
        //configure the cell
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = wordsSection[indexPath.row]
        return cell
    }
    
    //UITableViewDatasource methods
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return classes.count
    }
    
    //Sets the header value for each section
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return classes[section]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("Assignments", ofType: "plist")
        
        allAssignments = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        classes = Array(allAssignments.keys)
        classes.sortInPlace({$0 < $1})
        
        
//        //search results
//        let resultsController = SearchResultsController() //create an instance of our SearchResultsController class
//        resultsController.allAssignments = allAssignments
//        resultsController.classes = classes
//        searchController = UISearchController(searchResultsController: resultsController) //create a search controller and initialize with our SearchResultsController instance
//        
//        //search bar configuration
//        searchController.searchBar.placeholder = "Enter a search term" //place holder text
//        searchController.searchBar.sizeToFit() //sets appropriate size for the search bar
//        tableView.tableHeaderView=searchController.searchBar //install the search bar as the table header
//        searchController.searchResultsUpdater = resultsController //sets the instance to update search results
//  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

