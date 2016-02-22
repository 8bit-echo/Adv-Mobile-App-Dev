//
//  DetailViewController.swift
//  pictureCollection
//
//  Created by Matt Dickey on 2/18/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageName : String?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = imageName {
            imageView.image = UIImage(named:name)
        }
        
        
        
        
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
