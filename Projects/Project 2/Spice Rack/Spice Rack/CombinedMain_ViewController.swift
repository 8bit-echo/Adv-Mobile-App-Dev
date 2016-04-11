//
//  CombinedMain_ViewController.swift
//  Spice Rack
//
//  Created by Matt Dickey on 4/5/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit
import RealmSwift

class CombinedMain_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let database = try! Realm()
    let reuseIdentifier = "spiceCell"
    var spicetoDetail : Spice?
    var currentRack : Results<Spice>!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //Views
    @IBOutlet weak var collectionParent: UIView!
    @IBOutlet weak var tableParent: UIView!
    @IBOutlet weak var segmentParent: UIView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    
    
    // MARK: - IBActions
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        
        if segue.identifier == "doneSegue"{
            readAndUpdate()
            
        }else{
            readAndUpdate()
        }
        
    }
    @IBAction func doneSegue(segue: UIStoryboardSegue){
    }
    @IBAction func segmentSelectionChanged(sender: AnyObject) {
        let selectedSegment = segmentBar.selectedSegmentIndex
        
        if selectedSegment == 0 {
            collectionParent.hidden = false
            tableParent.hidden = true
            segmentParent.backgroundColor = UIColor.clearColor()
            segmentBar.tintColor = UIColor.whiteColor()
            
            navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
            navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.blueColor()
        }else if selectedSegment == 1{
            collectionParent.hidden = true
            tableParent.hidden = false
            segmentParent.backgroundColor = UIColor.clearColor()
            segmentBar.tintColor = UIColor.whiteColor()
            navigationController?.navigationBar.barTintColor = UIColor.blackColor()
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        }
        readAndUpdate()
    }
    
    
    // MARK: - My Functions
    func readAndUpdate(){
        currentRack = database.objects(Spice)
        collectionView?.reloadData()
        tableView.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        readAndUpdate()
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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentRack.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SpiceTableViewCell
        
        let spice = currentRack[indexPath.row]
        let spiceName = spice.name.capitalizedString
        let percentRemaining = spice.percentageRemaining.roundToPlaces(2)
        
        //Labels
        cell.customTextLabel?.text = spiceName
        cell.customTextLabel?.textColor = UIColor.whiteColor()
        cell.customDetailTextLabel?.text = "\(percentRemaining)%"
        cell.customDetailTextLabel?.textColor = UIColor.whiteColor()
        
        if spice.percentageRemaining <= 10 {
            cell.customDetailTextLabel?.textColor = UIColor.redColor()
        }
        
        //background image
        if let image = spice.imageName{
            let bgImage = UIImage(named:"\(image)-detail")
            let bgImageView = UIImageView(image: bgImage)
            bgImageView.contentMode = UIViewContentMode.ScaleAspectFill
            
//            let blur = UIBlurEffect(style: .Dark)
//            let effectView = UIVisualEffectView.init(effect: blur)
//            effectView.frame = self.view.frame
//            effectView.frame.offsetInPlace(dx: -(CGFloat((100 - spice.percentageRemaining))/100) * CGFloat(self.view.frame.width), dy: 0)
            
            //playing with effects
            let darkFilterView = UIView()
            darkFilterView.backgroundColor = UIColor.blackColor()
            darkFilterView.frame = self.view.frame
            darkFilterView.alpha = 0.6
            
            //print("\(spice.name) has \(spice.percentageRemaining)%. offset calculated to be \((CGFloat((100 - spice.percentageRemaining))/100) * CGFloat(effectView.frame.width)) / \(effectView.frame.width))")
            
            //bgImageView.addSubview(effectView)
            bgImageView.addSubview(darkFilterView)
            cell.backgroundView = bgImageView
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        spicetoDetail = currentRack[indexPath.row]
        performSegueWithIdentifier("showDetails", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let shelf = UIImage(named: "newshelf.jpg")
        self.collectionView?.backgroundColor = UIColor(patternImage: shelf!)
        readAndUpdate()
        segmentBar.tintColor = UIColor.whiteColor()
        
        
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
