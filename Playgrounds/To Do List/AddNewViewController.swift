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

    
    //--------- Keyboard Things ----------//
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    
    // --------- Other Things -----------//
    
    func checkNotify(){
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        if settings?.types.rawValue == 0{
            let alert = UIAlertController(title: "Can't schedule notifications", message: "Please go to Settings and enable Notifcations", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        nameTextField.delegate = self
        super.viewDidLoad()
        checkNotify()
        
        
        // Do any additional setup after loading the view.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "doneSegue"{
            if nameTextField.text?.isEmpty == false {
                addedItem = ToDoItem(newName: nameTextField.text!, newReminderDate: datePicker.date, newID: NSUUID().UUIDString)
            }
        }
    }
    
}
