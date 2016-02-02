

import UIKit

//via Github user Arshad @ https://gist.github.com/arshad/de147c42d7b3063ef7bc
func hexStringToUIColor (hex:String) -> UIColor {
    let cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
    
    if ((cString.characters.count) != 6) {
        return UIColor.grayColor()
    }
    
    var rgbValue:UInt32 = 0
    NSScanner(string: cString).scanHexInt(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    let letters = ["a", "b", "c", "d", "e", "f"]
    let numbers = [0, 1, 2 ,3 ,4 ,5]
    let hex = [" ", "0", "1", "2", "3", "4", "5", "a", "b" ,"c", "d", "e", "f"]
    var input = ""
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var colorView: UIView!
    @IBAction func clearResults(sender: UIButton) {
        hexLabel.text = "#"
        colorView.backgroundColor = UIColor.whiteColor()
        hexLabel.textColor = UIColor.blackColor()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 6
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hex.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hex[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        hexLabel.text?.append(Character(hex[row]))
        if hexLabel.text?.characters.count == 7{
            convert()
        }
    }
    
    func convert(){
        if hexLabel.text?.characters.count == 7{
            input = hexLabel.text!
            input.removeAtIndex(input.startIndex)
            print(input)
        }
        let selectedUIColor = hexStringToUIColor(input)
        colorView.backgroundColor = selectedUIColor
        
        var hue : CGFloat = 0.0
        var saturation : CGFloat = 0.0
        var brightness : CGFloat = 0.0
        var alpha : CGFloat = 0.0
        
        selectedUIColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        if brightness < 0.5 {
        hexLabel.textColor = UIColor.whiteColor()
        }else if brightness > 0.5{
            hexLabel.textColor = UIColor.blackColor()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hexLabel.text = "#"
    }
    
}

