//
//  AddNewViewController.swift
//  To Do List
//
//  Created by Matt Dickey on 2/23/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var addedItem : ToDoItem?
    
    //KEYBOARD METHODS
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        nameTextField.delegate = self
        super.viewDidLoad()
        
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
        
        
        if segue.identifier == "doneSegue"{
            if nameTextField.text?.isEmpty == false {
                addedItem = ToDoItem(newName: nameTextField.text!, newReminderDate: datePicker.date, newID: NSUUID().UUIDString)
            }
        }
    }
    
}
