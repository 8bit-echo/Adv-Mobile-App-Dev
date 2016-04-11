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

                
                //Handle Spice Image
                switch newSpice.name.lowercaseString {
                    
                case "bay leaves", "bay leaf":
                    newSpice.imageName = "bay-leaves"
                    
                case "beige", "ground mustard", "french fry seasoning", "ground ginger", "ground cardamom", "cardamom":
                    newSpice.imageName = "beige-powder"
                    
                case "brown sugar":
                    newSpice.imageName = "brown-sugar"
                    
                case "pumpkin pie spice", "ground nutmeg", "nutmeg":
                    newSpice.imageName = "burnt-orange-powder"
                    
                case "cajun", "cajun seasoning", "crushed red pepper", "red pepper", "cajun creole seasoning", "rub seasoning":
                    newSpice.imageName = "cajun"
                    
                case "cinnamon sticks":
                    newSpice.imageName = "cinnamon-sticks"
                    
                case "coffee", "cloves", "ground cloves", "crushed cloves":
                    newSpice.imageName = "dark-brown-powder"
                    
                case "peppercorns", "black peppercorns","whole cardamom seeds":
                    newSpice.imageName = "dark-peppercorns"
                    
                case "red", "ancho chili pepper", "chili powder" :
                    newSpice.imageName = "dark-red-powder"
                    
                case "italian blend", "italian seasoning", "zesty seasoning blend", "zesty seasoning":
                    newSpice.imageName = "dead-leafy"
                    
                case "fennel seed":
                    newSpice.imageName = "fennel-seed"
                    
                case "oregano", "dill weed", "parsley", "parsley flakes", "thyme", "thyme leaves":
                    newSpice.imageName = "green-leafy"
                    
                case "cinnamon", "allspice", "garam masala":
                    newSpice.imageName = "light-brown-powder"
                    
                case "garlic", "garlic powder", "garlic bread sprinkle":
                    newSpice.imageName = "offwhite-powder"
                    
                case "curry", "curry powder", "cayenne":
                    newSpice.imageName = "orange-powder"
                    
                case "paprika", "smoked paprika", "chipotle chile pepper":
                    newSpice.imageName = "red-powder"
                    
                case "rosemary", "rosemary leaves":
                    newSpice.imageName = "rosemary"
                    
                case "pepper", "black ground pepper":
                    newSpice.imageName = "pepper"
                    
                case "saffron":
                    newSpice.imageName = "saffron"
                    
                case "salt", "granulated onion":
                    newSpice.imageName = "white-crystal"
                
                case "star anise":
                    newSpice.imageName = "star-anise"
                    
                case "sugar", "garlic salt", "cream of tartar", "ranch powder":
                    newSpice.imageName = "white-powder"
                    
                case "whole cloves":
                    newSpice.imageName = "whole-cloves"
                    
                case "coriander", "poultry seasoning", "ground sage", "ground coriander", "ground coriander seed":
                    newSpice.imageName = "yellow-green"
                    
                case "mustard", "cumin", "tumeric":
                    newSpice.imageName = "yellow-powder"
                    
                default:
                    newSpice.imageName = String()
                    
//            case "":
//                  newSpice.imageName = ""
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
    
    
    // Mark: - My functions
    
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


