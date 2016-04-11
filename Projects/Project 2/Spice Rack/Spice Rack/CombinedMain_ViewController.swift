//
//  CombinedMain_ViewController.swift
//  Spice Rack
//
//  Created by Matt Dickey on 4/5/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit
import RealmSwift

//https://www.raywenderlich.com/113772/uisearchcontroller-tutorial

class CombinedMain_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    let database = try! Realm()
    let reuseIdentifier = "spiceCell"
    var spicetoDetail : Spice?
    var currentRack : Results<Spice>!
    var allSpices = [Spice]()
    var sortedbyRunningLow : Results<Spice>!
    var searchResults = [Spice]()
    
    // Interface
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    //Views
    @IBOutlet weak var collectionParent: UIView!
    @IBOutlet weak var tableParent: UIView!
    //@IBOutlet weak var segmentParent: UIView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    
    
    // MARK: - IBActions
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        readAndUpdate()
        print("CombinedMainVC readAndUpdate from unwindSegue()")
        
    }
    @IBAction func doneSegue(segue: UIStoryboardSegue){
    }
    @IBAction func segmentSelectionChanged(sender: AnyObject) {
        let selectedSegment = segmentBar.selectedSegmentIndex
        
        if selectedSegment == 0 {
            collectionParent.hidden = false
            tableParent.hidden = true
            //segmentParent.backgroundColor = UIColor.clearColor()
            //segmentBar.tintColor = UIColor.whiteColor()
        }else if selectedSegment == 1{
            collectionParent.hidden = true
            tableParent.hidden = false
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
            //segmentParent.backgroundColor = UIColor.clearColor()
            //segmentBar.tintColor = UIColor.whiteColor()
//            navigationController?.navigationBar.barTintColor = UIColor.clearColor()
//            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//            navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        }
        readAndUpdate()
        print("CombinedMainVC readAndUpdate from segmentSelectionChanged()")
    }
    
    
    // MARK: - My Functions
    func readAndUpdate(){
        currentRack = database.objects(Spice)
        currentRack = currentRack.sorted("name")
        allSpices = Array(currentRack)
        
        sortedbyRunningLow = database.objects(Spice).filter("percentageRemaining <= 10.0").sorted("name")
        print(sortedbyRunningLow.count)
        
        
        collectionView?.reloadData()
        tableView.reloadData()
    }
    func buildSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    func setCollectionViewBackground(imageName : String){
        let shelf = UIImage(named: imageName)
        self.collectionView?.backgroundColor = UIColor(patternImage: shelf!)
    }
    func designUI(){
//        navigationController?.navigationBar.barTintColor = UIColor.customGreenColor()
//        navigationController?.navigationBar.tintColor = UIColor.customGreenColor()
//        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.customGreenColor()]
//        navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.customGreenColor()
    }
    
    // MARK: CollectionView Requirements
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentRack.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)  as! SpiceJar_CollectionViewCell
        
        let spice = currentRack[indexPath.row]
        let spiceName = spice.name.capitalizedString
        let percentageRemaining = spice.percentageRemaining
        let imageOffset = (100 - (1.05 * percentageRemaining))
        
        
        //set the Label to the Spice Name
        cell.spiceNameLabel.text = spiceName
        cell.spiceNameLabel.textColor = UIColor.whiteColor()
        cell.spiceNameLabel.shadowColor = UIColor.blackColor()
        if spice.percentageRemaining <= 10 {
            cell.spiceNameLabel.textColor = UIColor.redColor()
        }
        
        
        //Get The Appropriate texture based on name
        if let image = spice.imageName{
            cell.spiceTextureImage.image = UIImage(named: image)
        }
        
        //Create and image mask to illustrate quantity
        if let maskImage = UIImage(named: "jarmask-ti.png"){
            cell.spiceTextureImage.maskView = UIImageView(image: maskImage)
        }
        let mask = cell.spiceTextureImage.maskView!
        //modify it's position
        mask.frame.origin = CGPoint(x: 2.0, y: 9.0)
        //modify it's vertical offset and max points.
        mask.frame.offsetInPlace(dx: 0.0, dy: CGFloat(imageOffset))
        mask.frame.size = CGSize(width: 95, height: 134)
        
        
        //this line is needed for the cell size to initalize correctly on the first load of the thread. IDK why...
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        spicetoDetail = currentRack[indexPath.row]
        performSegueWithIdentifier("showDetails", sender: nil)
    }
    
    
    
    //Mark: - TableView Requirements
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != ""{
            return searchResults.count
        }
            return currentRack.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SpiceTableViewCell
        
        var spice : Spice
        //search
        if searchController.active && searchController.searchBar.text != "" {
            spice = searchResults[indexPath.row]
        } else {
            spice = allSpices[indexPath.row]
        }
        let spiceName = spice.name.capitalizedString
        let percentRemaining = spice.percentageRemaining.roundToPlaces(2)
        
        //Labels
        cell.customTextLabel?.text = spiceName
        cell.customTextLabel?.textColor = UIColor.whiteColor()
        cell.customDetailTextLabel?.text = "\(Int(percentRemaining))%"
        cell.customDetailTextLabel?.textColor = UIColor.whiteColor()
        
        if spice.percentageRemaining <= 10 {
            cell.customDetailTextLabel?.textColor = UIColor.redColor()
        }
        
        //background image
        if let image = spice.imageName{
            let bgImage = UIImage(named:"\(image)-detail")
            let bgImageView = UIImageView(image: bgImage)
            bgImageView.contentMode = UIViewContentMode.ScaleAspectFill
            
            //dark overlay effect
            let darkFilterView = UIView()
            darkFilterView.backgroundColor = UIColor.blackColor()
            darkFilterView.frame = self.view.frame
            darkFilterView.alpha = 0.6

            bgImageView.addSubview(darkFilterView)
            cell.backgroundView = bgImageView
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        spicetoDetail = currentRack[indexPath.row]
        performSegueWithIdentifier("showDetails", sender: nil)
    }
    
    //search
    func filterContentForSearchText(searchText : String, scope : String = "All"){
        searchResults = Array(currentRack).filter { spice in
            return spice.name.lowercaseString.containsString(searchText.lowercaseString)}
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewBackground("darkshelf")
        readAndUpdate()
        buildSearchBar()
        designUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showDetails" && spicetoDetail != nil) {
            let showDetailsVC = segue.destinationViewController as! SpiceDetails_ViewController
            showDetailsVC.receivedObject = spicetoDetail
        }
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
}



//Extends main ViewController for search Functionality
extension CombinedMain_ViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
