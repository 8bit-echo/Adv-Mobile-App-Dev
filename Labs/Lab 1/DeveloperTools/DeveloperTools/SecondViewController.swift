//
//  SecondViewController.swift
//  DeveloperTools
//
//  Created by Matt Dickey on 1/24/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var typefacePicker: UIPickerView!
    @IBOutlet weak var demoLabel: UILabel!
    @IBOutlet weak var fontSlider: UISlider!
    @IBOutlet weak var weightLabel: UILabel!
    
    let typefaces = ["Baskerville","Copperplate","Didot","Helvetica Neue","Times"]
    var fonts = ["UltraLight","Light","Thin","Normal","Medium","Bold"]
    var selectedTypeface = "Helvetica Neue"
    var selectedFont = "Normal"
    var numberOfFonts = 0
    
    @IBAction func sliderChanged(sender: UISlider) {
        updateFont()
    }
    
    //Required Picker Components
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typefaces.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typefaces[row]
    }
    
    
    //When Row is selected, change the typeface
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let componentFromPicker = typefacePicker.selectedRowInComponent(0)
        selectedTypeface = typefaces[componentFromPicker]
        print("\(selectedTypeface) is the currently selected typeface")
        updateTypeface()
        
    }
    
    
    
    func updateTypeface(){
        demoLabel.font = UIFont(name: selectedTypeface, size: 17.0)
        
        //Change the Font array based on the appropriate Typeface
        let typeface = selectedTypeface
        
        switch typeface {
        case "Baskerville":
            fonts = ["Regular", "SemiBold", "Bold"]
            
        case "Copperplate":
            fonts = ["Light", "Regular", "Bold"]
            
        case "Didot":
            fonts = ["Regular", "Bold"]
            
        case "Helvetica Neue":
            fonts = ["UltraLight","Thin","Light","Normal","Medium","Bold"]
            
        case "Times":
            fonts = ["Regular", "Bold"]
            
        default:
            break
        }
        
        //The slider needs to have maximum values of the number of items in the array
        fontSlider.maximumValue = Float(fonts.count - 1)
        
        print("Maximum Slider Value set to \(fontSlider.maximumValue)")
        print("[fonts] is now set to \(selectedTypeface) and contains \(fonts.count) items : \([fonts])")
        
        print("updateTypeface() has finished running")
        
    }
    
    func updateFont(){
        //current slider value to int
        let selectedSliderValue = Int(fontSlider.value)
        print("slider value is currently \(selectedSliderValue)")
        
        //that int is the index number of the font
        selectedFont = fonts[selectedSliderValue]
        
        //assign that font to the label
        
        weightLabel.text = selectedFont
        
        var fullFontName = selectedTypeface
        
        if selectedFont != "Regular"{
            fullFontName = selectedTypeface + "-" + selectedFont
        }
        
        if selectedTypeface == "Helvetica Neue"{
            selectedTypeface = "HelveticaNeue"
        }
        
        
        
        
        print(fullFontName)
        
        demoLabel.font = UIFont(name: fullFontName, size: 17.0)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTypeface = "BaskerVille"
        demoLabel.font = UIFont(name: selectedTypeface, size: 17.0)
        weightLabel.text = "Regular"
        
    }
    
    
    
}

