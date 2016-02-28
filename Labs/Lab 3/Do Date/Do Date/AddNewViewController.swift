//
//  AddNewViewController.swift
//  Do Date
//
//  Created by Matt Dickey on 2/14/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit
import RealmSwift
class AddNewViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var AssignmentNameTextField: UITextField!
    @IBOutlet weak var SubjectTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //Modify datePciker.dueDate to Midnight of the selected day
    func allowUntilMidnight(date: NSDate) -> NSDate{
        //StackOverflow user AstroCB @ http://stackoverflow.com/questions/26189656/how-can-i-set-an-nsdate-object-to-midnight
        let oldDate = date
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let newDate = calendar.dateBySettingHour(23, minute: 59, second: 59, ofDate: oldDate, options: NSCalendarOptions())
        
        return newDate!
    }
    
    
    

    func saveEntries() {
        let userInputName = AssignmentNameTextField.text
        let userInputSubject = SubjectTextField.text
        let userInputDate = allowUntilMidnight(datePicker.date)
        
        let newAssignment = Assignment()
        
        newAssignment.name = userInputName!
        newAssignment.subject = userInputSubject!
        newAssignment.dueDate = userInputDate
        
        let uiRealm = try! Realm()
        
        try! uiRealm.write({
            uiRealm.add(newAssignment)
        })
        
        print("SaveEntries() complete.")
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        AssignmentNameTextField.resignFirstResponder()
        SubjectTextField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AssignmentNameTextField.delegate = self
        SubjectTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveSegue"{
            saveEntries()
            
        }
    }
}