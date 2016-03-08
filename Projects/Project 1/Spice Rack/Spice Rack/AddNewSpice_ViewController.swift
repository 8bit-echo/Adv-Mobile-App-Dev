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


class AddNewSpice_ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - Global Variables
    let database = try! Realm()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spiceNameTextField: UITextField!
    @IBOutlet weak var volumePurchasedTextField: UITextField!
    @IBOutlet weak var volumePicker: UIPickerView!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var percentageLabel: UILabel!
    let numbers = [0,1,2,3,4,5,6,7,8,9]
    let units = ["grams", "oz"]
    var currentSliderValue = 100
    
    
    // MARK: - @IBActions
    @IBAction func sliderValueChanged(sender: UISlider) {
        currentSliderValue = Int(sender.value)
        
        percentageLabel.text = String(currentSliderValue) + "%"
        
    }
    @IBAction func showMoreOptions(sender: AnyObject) {
    }
    @IBAction func doneButton(sender: UIBarButtonItem) {
        //Check for blank fields
        // if blank present error window
        //else save & unwind
        
        let userSpiceName = spiceNameTextField.text
        let userVolume = volumePurchasedTextField.text
        let unit = "oz"
        let newSpice = Spice()
        
        if (spiceNameTextField.text!.isEmpty || volumePurchasedTextField.text!.isEmpty){
            let alertController = UIAlertController(title: "Can't Save", message:
                "Please enter a name and Net Weight", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            print("Save Function detected errors in the input")
        } else {
            newSpice.name = userSpiceName!
            newSpice.unit = unit
            newSpice.netWt = Double(userVolume!)!
            
            try! database.write({database.add(newSpice)})
            print("Saved to database")
            
            performSegueWithIdentifier("doneSegue", sender: nil)
        }
        
    }
    

    
    
    // MARK: - Included
    override func viewDidLoad() {
        super.viewDidLoad()
        spiceNameTextField.delegate = self
        volumePicker.delegate = self
        volumePicker.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        spiceNameTextField.resignFirstResponder()
        return true
    }
    
    
    
    // MARK: - Navigation
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //      }
    
    
    // MARK: - PickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 2 {
            return units.count
        }else{
            return numbers.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "String"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
}
//End of Class


