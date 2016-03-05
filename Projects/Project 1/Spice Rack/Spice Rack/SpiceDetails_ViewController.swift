//
//  SpiceDetails_ViewController.swift
//  Spice Rack
//
//  Created by Matt Dickey on 3/1/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit
import RealmSwift

//http://stackoverflow.com/questions/29569314/passing-value-to-another-viewcontroller-upon-selecting-cell-in-uicollectionview


class SpiceDetails_ViewController: UIViewController {
    
    // MARK: - Global Variables
    let database = try! Realm()
    var receivedObject : Spice?
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var percentageLabel: UILabel!
    
    
    // MARK: - IBActions
    @IBAction func showDetailSegue(segue: UIStoryboardSegue){}
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        let currentSliderValue = Int(sender.value)
        percentageLabel.text = String(currentSliderValue) + "%"
        
        let volumeRemaining = receivedObject!.netWt * Double(sender.value/100).roundToPlaces(1)
        
        
        label2.text = String(volumeRemaining) + " oz"
        
        try! database.write {
            receivedObject!.volumeRemaining = volumeRemaining
        }

    }
    
    @IBAction func saveChanges(sender: AnyObject) {
        
    }
    
    // MARK: - My Functions
    
    
    
    // MARK: - Included
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label1.text = receivedObject!.name.capitalizedString
        label2.text = String(receivedObject!.volumeRemaining) + " oz"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "trashSegue"{
                try! database.write({
                    database.delete(receivedObject!)
                })
        }
        
    }


} // End of Class

