  import UIKit
  
  extension String {
        
        subscript (i: Int) -> Character {
            return self[self.startIndex.advancedBy(i)]
        }
        
        subscript (i: Int) -> String {
            return String(self[i] as Character)
        }
        
        subscript (r: Range<Int>) -> String {
            let start = startIndex.advancedBy(r.startIndex)
            let end = start.advancedBy(r.endIndex - r.startIndex)
            return self[Range(start: start, end: end)]
        }
    }
    
    var hex = "A"
    var hValue = 0
    var dec = 0
    var dValue = "A"
    var input = "a1b2c3"
    
    
    
    func giveDec(hex:Character) -> Int{
        
        switch hex {
            
        case "A":
            hValue = 10
        case "B":
            hValue = 11
        case "C":
            hValue = 12
        case"D":
            hValue = 13
        case "E":
            hValue = 14
        case "F":
            hValue = 15
        default:
            hValue = 00
        }
        return hValue
    }
    
    func giveHex(dec: Int) -> String{
        switch dec{
            
        case 10:
            dValue = "A"
        case 11:
            dValue = "B"
        case 12:
            dValue = "C"
        case 13:
            dValue = "D"
        case 14:
            dValue = "E"
        case 15:
            dValue = "F"
        default: "Error"
            
        }
        return dValue
        
    }
    
    
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
  
  
  let white = hexStringToUIColor("ffffff")
  
  
  let selectedColor = UIColor.grayColor()
  
  var hue : CGFloat = 0.0
  var saturation : CGFloat = 0.0
  var brightness : CGFloat = 0.0
  var alpha : CGFloat = 0.0
  
  selectedColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
  
  print(brightness)
  
  
  
  
  
  
  
    var test = UIFont.fontNamesForFamilyName("Helvetica Neue")
    print(test)
  
  var myString = "grumpy wizards do things blah blah blah"
  
  
  var myFloat : Float = 3.34
  
  let closestIntToSliderValue = Int(round(myFloat))
  

  
  
  
  
  
  
    
    
