//
//  SpiceRack-CollectionViewController.swift
//  Spice Rack
//
//  Created by Matt Dickey on 3/1/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit
import RealmSwift
//import QuartzCore

//http://stackoverflow.com/questions/5757386/how-to-mask-an-uiimageview

//print(Realm.Configuration.defaultConfiguration.path!)


class SpiceRack_CollectionViewController: UICollectionViewController{
    
    // MARK: - Global Variables
    let database = try! Realm()
    let reuseIdentifier = "spiceCell"
    @IBOutlet weak var jarImageView: UIImageView!
    @IBOutlet weak var spiceTextureImageView: UIImageView!
    @IBOutlet weak var spiceNameLabel: UILabel!
    var spicetoDetail : Spice?
    var currentRack : Results<Spice>!
    
    
    // MARK: - IBActions
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        
        if segue.identifier == "doneSegue"{
            readAndUpdate()
            
        }else{
            readAndUpdate()
        }
        
    }
    
    
    // MARK: - My Functions
    func readAndUpdate(){
        currentRack = database.objects(Spice)
        collectionView?.reloadData()
        
    }
    
    
    // MARK: -  Included
    override func viewDidLoad() {
        super.viewDidLoad()
        let shelf = UIImage(named: "newshelf.jpg")
        self.collectionView?.backgroundColor = UIColor(patternImage: shelf!)
        
        //self.navigationController?.navigationBar.barTintColor = UIColor.clearColor()
        //self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]

    }
    
    override func viewWillAppear(animated: Bool) {
        readAndUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    @IBAction func doneSegue(segue:UIStoryboardSegue){
    }
    
    
    // MARK: CollectionView Requirements
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentRack.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SpiceJar_CollectionViewCell
        
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
        
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        spicetoDetail = currentRack[indexPath.row]
        performSegueWithIdentifier("showDetails", sender: nil)
    }

    
    
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}
