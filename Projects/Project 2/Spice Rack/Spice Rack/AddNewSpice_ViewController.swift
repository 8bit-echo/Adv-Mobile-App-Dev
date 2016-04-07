//
//  AddNewSpice_ViewController.swift
//  Spice Rack
//
//  Created by Matt Dickey on 3/1/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit
import RealmSwift


//Food2Fork API KEY - 613a0c14db1697aa0f221ea66e1cec08
// http://stackoverflow.com/questions/26819423/show-uipickerview-text-field-is-selected-then-hide-after-selected


class AddNewSpice_ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    // MARK: - Global Variables
    let database = try! Realm()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spiceNameTextField: UITextField!
    @IBOutlet weak var volumePurchasedTextField: UITextField!
    @IBOutlet weak var volumePicker: UIPickerView!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var percentageLabel: UILabel!
    let numbers = ["",0,1,2,3,4,5,6,7,8,9]
    let units = ["g", "oz"]
    var currentSliderValue = 100
    var selectedPickerValues = ["","","",".","","g"]
    var fullVolumeString = String()
    var userUnit = String()
    var userVolume = Double()
    
    // Mark: - Optional properties
    @IBOutlet weak var brandTextField: UITextField!
    
    
    
    // MARK: - @IBActions
    @IBAction func sliderValueChanged(sender: UISlider) {
        currentSliderValue = Int(sender.value)
        
        percentageLabel.text = String(currentSliderValue) + "%"
        
    }
    @IBAction func showMoreOptions(sender: AnyObject) {
        brandTextField.hidden = false
    }
    @IBAction func doneButton(sender: UIBarButtonItem) {
        //Check for blank fields
        // if blank present error window
        //else save & unwind
        
        let userSpiceName = spiceNameTextField.text
        let newSpice = Spice()
        
        if (spiceNameTextField.text!.isEmpty || userVolume == 0.0){
            let alertController = UIAlertController(title: "Can't Save", message:
                "Please enter a name and Net Weight", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // Required Fields
            newSpice.name = userSpiceName!
            newSpice.unit = userUnit
            newSpice.netWt = userVolume
            newSpice.volumeRemaining = Double(Float(userVolume) * volumeSlider.value/100)
            newSpice.calculatePercentage()
            
            
            //Optional Fields
            
            if let definiteBrand = brandTextField.text {
                newSpice.brand = definiteBrand
            }

            //purchase and exp date
            
            
            //Handle Spice Image
            switch newSpice.name.lowercaseString {
                
            case "beige":
                newSpice.imageName = "beige-powder"
                
            case "brown sugar":
                newSpice.imageName = "brown-sugar"
                
            case "cajun":
                newSpice.imageName = "cajun"
                
            case "cinnamon sticks":
                newSpice.imageName = "cinnamon-sticks"
                
            case "coffee":
                newSpice.imageName = "dark-brown-powder"
                
            case "pepper", "black pepper", "peppercorns":
                newSpice.imageName = "dark-peppercorns"
                
            case "red" :
                newSpice.imageName = "dark-red-powder"
                
            case "italian blend":
                newSpice.imageName = "dead-leafy"
                
            case "oregano":
                newSpice.imageName = "green-leafy"
                
            case "cloves", "ground cloves", "crushed cloves", "cinnamon", "allspice":
                newSpice.imageName = "light-brown-powder"
                
            case "garlic", "garlic powder":
                newSpice.imageName = "offwhite-powder"
                
            case "curry", "curry powder", "cayenne":
                newSpice.imageName = "orange-powder"
                
            case "paprika":
                newSpice.imageName = "red-powder"
            case "pepper":
                newSpice.imageName = "pepper"
                
            case "saffron":
                newSpice.imageName = "saffron"
                
            case "salt":
                newSpice.imageName = "white-crystal"
                
            case "sugar", "garlic salt":
                newSpice.imageName = "white-powder"
                
            case "whole cloves":
                newSpice.imageName = "whole-cloves"
                
            case "coriander":
                newSpice.imageName = "yellow-green"
                
            case "mustard", "cumin":
                newSpice.imageName = "yellow-powder"
                
            default:
                newSpice.imageName = String()
                
                //            case "":
                //                newSpice.imageName = ""
            }
            
            try! database.write({database.add(newSpice)})
            
            print("saving item \(newSpice)")
            
            performSegueWithIdentifier("doneSegue", sender: nil)
        }
        
    }
    @IBAction func exitTap(sender: UITapGestureRecognizer) {
        spiceNameTextField.resignFirstResponder()
        volumePicker.hidden = true
        
    }
    
    
    // MARK: - Included
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spiceNameTextField.delegate = self
        self.volumePurchasedTextField.delegate = self
        volumePicker.delegate = self
        volumePicker.dataSource = self
        volumePicker.hidden = true
        brandTextField.hidden = true
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if textField.tag == 1 {
            spiceNameTextField.resignFirstResponder()
            volumePicker.hidden = false
            return false
        }else{
            return true
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
        volumePicker.hidden = true
    }

    
    
    
    // MARK: - Navigation
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //      }
    
    
    // MARK: - PickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 6
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 5 {
            return units.count
        }else if component == 3{
            return 1
        }
        else{
            return numbers.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var titleForRow = String()
        
        if component == 3 {
            titleForRow = "."
        } else if component == 5{
            titleForRow = units[row]
        }else{
            titleForRow = String(numbers[row])
        }
        
        return titleForRow
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fullVolumeString = ""
        volumePurchasedTextField.text = ""
        var rawValueAsString = String()
        
        
        switch component {
        case 0:
            selectedPickerValues[component] = String(numbers[row])
        case 1:
            selectedPickerValues[component] = String(numbers[row])
        case 2:
            selectedPickerValues[component] = String(numbers[row])
        case 3:
            selectedPickerValues[component] = "."
        case 4:
            selectedPickerValues[component] = String(numbers[row])
        case 5:
            selectedPickerValues[component] = units[row]
        default:
            break
        }
        
        //Set the combination of picker values to the textField
        for value in selectedPickerValues {
            fullVolumeString += String(value)
            volumePurchasedTextField.text = fullVolumeString
        }
        
        //Update the data model for the new object
        userUnit = selectedPickerValues[5]
        
        for number in selectedPickerValues[0...4]{
            rawValueAsString += number
        }
        if rawValueAsString != "."{
            userVolume = Double(rawValueAsString)!
        }
    }
    
    
    
}
//End of Class


