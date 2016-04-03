

import UIKit
import Firebase

class AddNewViewController: UIViewController, UITextFieldDelegate {
    
    var addedStudent = String()
    var addedBackground = String()
    let ref = Firebase(url: "https://ctd-students.firebaseio.com")
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var backgroundTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if (nameTextField.text!.isEmpty || backgroundTextField.text!.isEmpty){
            showAlert("Can't Save", message: "Both text fields are required", actionText: "Okay")
        }else{
            if segue.identifier == "doneSegue"{
                addedStudent = nameTextField.text!
                addedBackground = backgroundTextField.text!
                
                
                let source = segue.sourceViewController as! AddNewViewController
                let newStudent = Student(name: source.addedStudent, background: source.addedBackground)
                
                let destination = segue.destinationViewController as! StudentListTableViewController
                
                destination.allStudents.append(newStudent)
                
                let newDict = ["name" : source.addedStudent, "background" : source.addedBackground]
                
                let studentRef = ref.childByAppendingPath(source.addedStudent)
                studentRef.setValue(newDict)
            }
        }
        
        
    }
    
    
    func showAlert(title: String, message: String, actionText: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: actionText, style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}
