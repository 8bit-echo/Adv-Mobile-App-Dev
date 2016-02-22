//
//  CollectionViewController.swift
//  pictureCollection
//
//  Created by Matt Dickey on 2/16/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "Cell"
    var images = [String]()
    
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    var sharing = false
    var selectedImages = [String]()
    
    @IBAction func share(sender: AnyObject) {
        var imageArray = [UIImage]()
        if !selectedImages.isEmpty {
            print("share images")
            for imageName in selectedImages{
                imageArray.append(UIImage(named: imageName)!)
            }
        }
        let shareScreen = UIActivityViewController(activityItems: imageArray, applicationActivities: nil)
        shareScreen.modalPresentationStyle = .Popover
        shareScreen.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        presentViewController(shareScreen, animated: true, completion: nil)
        
        sharing = !sharing
        collectionView?.allowsMultipleSelection = sharing
        collectionView?.selectItemAtIndexPath(nil, animated: true, scrollPosition: .None)
        
        if !sharing {
            for cell in (collectionView?.visibleCells())!{
                cell.backgroundColor = UIColor.blackColor()
            }
            selectedImages.removeAll(keepCapacity: false)
        } 
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...10{
            images.append("etsy" + String(i))
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail"{
            let indexPath = collectionView?.indexPathForCell(sender as! CollectionViewCell)
            let detailVC = segue.destinationViewController as! DetailViewController
            detailVC.imageName = images[(indexPath?.row)!]
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell  //Cast This as a cell to make the connection.
        
        let image = UIImage(named: images[indexPath.row])
        cell.imageView.image = image
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var header : CollectionReusableView?
        if kind == UICollectionElementKindSectionHeader{
            header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as? CollectionReusableView
            header?.headerLabel.text = "Etsy Shop"
        }
        return header!
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let image = UIImage(named: images[indexPath.row])
        
        let newSize = CGSize (width: (image?.size.width)!/2.75, height: (image?.size.height)!/2.75)
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image?.drawInRect(rect)
        let image2 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return (image2?.size)!
    }
    
    
    // MARK: UICollectionViewDelegate
    

    // Uncomment this method to specify if the specified item should be highlighted during tracking
//    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//    return true
//    }

    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if sharing {
            let image = images[indexPath.row]
            if let foundIndex = selectedImages.indexOf(images[indexPath.row]){ //deselect and remove
            selectedImages.removeAtIndex(foundIndex)
            collectionView.cellForItemAtIndexPath(indexPath)?.backgroundColor = UIColor.blackColor()
        } else {
            //add and select
            selectedImages.append(image)
            collectionView.cellForItemAtIndexPath(indexPath)?.backgroundColor = UIColor.yellowColor()
            } }
            else {
            //segue to detail view controller
            self.performSegueWithIdentifier("showDetail", sender: collectionView.cellForItemAtIndexPath(indexPath))
        }
        return false
    }

    
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
