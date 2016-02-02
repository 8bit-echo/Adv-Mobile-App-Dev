//
//  SecondViewController.swift
//  Music
//
//  Created by Matt Dickey on 1/19/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var musicPicker: UIPickerView!
    @IBOutlet weak var labelResult: UILabel!

    let genre = ["Country", "Pop", "Rock", "Classical", "Alternative", "Hip Hop", "Jazz"]
    let decade = ["1950s", "1960s", "1970s", "1980s", "1990s", "2000s", "2010s"]
    
    
    //Picker Nonsense
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return genre.count
        } else {
            return decade.count
        }
    }

    //Picker Delegate methods
    //returns the title for the row
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return genre[row]
        } else {
            return decade[row]
        }
        
    }

    //Called when a row is selected
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let genrerow = pickerView.selectedRowInComponent(0) //gets the selected row for the genre
        let decaderow = pickerView.selectedRowInComponent(1) //gets the selected row for the decade
        labelResult.text="You like \(genre[genrerow]) from the \(decade[decaderow])"
    }
    
    
    override func viewDidLoad() {
        labelResult.text = ""
        super.viewDidLoad()

    }



}

