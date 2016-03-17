//
//  AddNew_ViewController.swift
//  JSON
//
//  Created by Matt Dickey on 3/17/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class AddNew_ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var recipeTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    var addedRecipe = String()
    var addedURL = String()
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTextField.delegate = self
        urlTextField.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "cancelSegue" {
            
        }
        else if segue.identifier == "saveSegue"{
            if recipeTextField.text?.isEmpty == false {
                addedRecipe = recipeTextField.text!
                addedURL = urlTextField.text!
            }
            
        }
    }
    
}
