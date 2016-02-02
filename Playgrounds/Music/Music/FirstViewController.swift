//
//  FirstViewController.swift
//  Music
//
//  Created by Matt Dickey on 1/19/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Global Varirables
    @IBOutlet weak var musicPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    let zero = 0
    
    let genre = ["Country", "Pop", "Rock", "Classical", "Alternative", "Hip-Hop", "Jazz"]
    
    
    //Music Picker Set up
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genre.count
    }
    
    //Picker Delegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genre[row]
    }
    //Called when row is selected
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choiceLabel.text = "You like \(genre[row])"
    }

    
    @IBAction func myButton(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choiceLabel.text = ""

    }



}

