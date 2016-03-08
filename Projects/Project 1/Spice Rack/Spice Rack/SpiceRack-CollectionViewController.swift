//
//  SpiceRack-CollectionViewController.swift
//  Spice Rack
//
//  Created by Matt Dickey on 3/1/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit
import RealmSwift

//http://stackoverflow.com/questions/5757386/how-to-mask-an-uiimageview

//print(Realm.Configuration.defaultConfiguration.path!


class SpiceRack_CollectionViewController: UICollectionViewController {
    
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
        self.collectionView?.reloadData()
        
    }
    
    
    // MARK: -  Included
    override func viewDidLoad() {
        super.viewDidLoad()
        readAndUpdate()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        

        // Do any additional setup after loading the view.
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
        let spiceName = currentRack[indexPath.row].name.capitalizedString
        
        cell.spiceNameLabel.text = spiceName
        cell.spiceTextureImage.frame = CGRect(x: 0, y: -50, width: 100, height: 50)
        
        switch spiceName{
        case "Oregano":
            cell.spiceTextureImage.image = UIImage(named: "green-leafy.png")
        case "Garlic":
            cell.spiceTextureImage.image = UIImage(named: "offwhite-powder.png")
        case "Cumin":
            cell.spiceTextureImage.image = UIImage(named: "orange-powder.png")
        case "Cinnamon":
            cell.spiceTextureImage.image = UIImage(named: "cinnamon.png")
        default:
            cell.spiceTextureImage.hidden = true;
        }
        
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
