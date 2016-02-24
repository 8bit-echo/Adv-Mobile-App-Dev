//
//  DetailViewController.swift
//  pictureCollection
//
//  Created by Matt Dickey on 2/18/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageName : String?
    let wcop = " Watercolor on Paper"
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var paintingTitle: UILabel!
    @IBOutlet weak var details: UILabel!
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        self.scrollView.minimumZoomScale=1.0;
        self.scrollView.maximumZoomScale=6.0;
        self.scrollView.contentSize=CGSizeMake(1280, 960);
        
        if let name = imageName {
            imageView.image = UIImage(named:name)
            
            switch name{
            case "etsy1":
                paintingTitle.text = "Angel"
                details.text = "2015." + wcop
            case "etsy2":
                paintingTitle.text = "Miss Anne R. Ekcia"
                details.text = "2014." + wcop
            case "etsy3":
                paintingTitle.text = "Barbie"
                details.text = "2014. Oil on Canvas"
            case "etsy4":
                paintingTitle.text = "Cadence"
                details.text = "2015." + wcop
            case "etsy5":
                paintingTitle.text = "Just a Freak Like Me"
                details.text = "2012." + wcop
            case "etsy6":
                paintingTitle.text = "Jasmine"
                details.text = "2015." + wcop
            case "etsy7":
                paintingTitle.text = "Fertile Myrtle"
                details.text = "2012. Acrylic on Layered Plexiglass"
            case "etsy8":
                paintingTitle.text = "The Octophant"
                details.text = "2014. Acrylic on Paper"
            case "etsy9":
                paintingTitle.text = "Olivia"
                details.text = "2015." + wcop
            case "etsy10":
                paintingTitle.text = "[Untitled]"
                details.text = "2012. Acrylic and Ink on Canvas"
            default:
                paintingTitle.text = ""
                details.text = ""
            }
        }
        
        
        var backButton = navigationController?.navigationItem.leftBarButtonItem
        backButton = navigationItem.backBarButtonItem
        backButton?.tintColor = UIColor.blackColor()
    }
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
