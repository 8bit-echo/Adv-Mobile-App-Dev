//
//  AddNew_ViewController.swift
//  Midterm
//
//  Created by Matt Dickey on 3/10/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit
import RealmSwift

class AddNew_ViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var itemTextField: UITextField!
    var itemToPass = String()
    
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("addNewDone", sender: nil)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        itemTextField.resignFirstResponder()
        return true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "addNewDone"{
            if itemTextField.text != nil {
                itemToPass = itemTextField.text!
                print("should Save text")
            }
        }
        
    }
    
}
