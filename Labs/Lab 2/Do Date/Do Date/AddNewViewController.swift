

import UIKit

class AddNewViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var assignmentTextField: UITextField!
    @IBOutlet weak var classTextField: UITextField!
    

    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignmentTextField.delegate = self
        classTextField.delegate = self
        

        // Do any additional setup after loading the view.
    }

    

        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
