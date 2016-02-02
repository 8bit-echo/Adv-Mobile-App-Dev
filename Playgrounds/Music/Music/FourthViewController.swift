//
//  FourthViewController.swift
//  Music
//
//  Created by Matt Dickey on 1/21/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    
    @IBAction func goToMusic(sender: UIButton) {
        
        if(UIApplication.sharedApplication().canOpenURL(NSURL(string: "pandora://")!)){
            UIApplication.sharedApplication().openURL(NSURL(string: "pandora://")!)
        } else {
            if(UIApplication.sharedApplication().canOpenURL(NSURL(string: "music://")!)){
                UIApplication.sharedApplication().openURL(NSURL(string: "music://")!)
            } else {
                UIApplication.sharedApplication().openURL(NSURL(string: "http://www.apple.com/music/")!)
            }
        }
    }

   
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }




}
