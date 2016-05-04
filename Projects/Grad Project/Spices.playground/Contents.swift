//: Playground - noun: a place where people can play

import UIKit
import Foundation

//http://stackoverflow.com/questions/27338573/rounding-a-double-value-to-x-number-of-decimal-places-in-swift user: Sebastian
extension Double {
    
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}

class Spice {
    var name : String = ""
    var netWt: Double = 0.0
    var unit : String
    var volumeRemaining : Double = 0.0
    var percentageRemaining : Double = 100.0
    //var image : UIImage = UIImage(named: " .png")!
    
    
    
    
    var brand : String?
    var purchaseDate : NSDate?
    var expDate : NSDate?
    
    
    func calculatePercentage() -> Double{
        percentageRemaining = (self.volumeRemaining / self.netWt) * 100
        return percentageRemaining.roundToPlaces(1)
    }
    
    
    func getDetails() -> String{
        let summary = String("You have \(volumeRemaining)\(unit) of \(name) from the original \(netWt)\(unit) container which is \(calculatePercentage())%.")
        
        return summary
    }
    
    init(name: String, netWt : Double, unit: String){
        self.name = name
        self.netWt = netWt
        self.unit  = unit
    }
    
}



//Variable called MySpiceRack holds a list of spices
var mySpiceRack = [Spice]()


//Oregano is an instance of a Spice
let oregano = Spice(name: "oregano", netWt: 2.5, unit: "oz")

//Cumin is an instance of a Spice
let cumin = Spice(name: "cumin", netWt: 3.0, unit: "oz")



//Set the remaining volume of the spice's respective containers
oregano.volumeRemaining = 1.3
cumin.volumeRemaining = 2.9


//Add Oregano and Cumin to the Rack
mySpiceRack.append(oregano)
mySpiceRack.append(cumin)



//Get how many Spices are currently in the rack
mySpiceRack.count


//get a summary of each spice in the rack
for spice in mySpiceRack{
    print(spice.getDetails())
}


func convertToGrams (ounces: Double) -> [Character]{
    //1oz = 28.35g
    let g = ounces * 28.35
    let limitedg = g.roundToPlaces(1)
    let gString = String(limitedg)
    
    let separatedComponents = Array(gString.characters)
    var finalComponents = [String]()
    
    for char in separatedComponents{
        let new = String(char)
        finalComponents.append(new)
    }
    
    finalComponents.append("g")
    
    return separatedComponents
}

func convertToOunces (grams: Double) -> [String]{
    // 1g = .035oz
    let oz = grams * 0.035
    let limitedOz = oz.roundToPlaces(1)
    let ozString = String(limitedOz)
    
    
    let separatedComponents = Array(ozString.characters)
    var finalComponents = [String]()
    
    for char in separatedComponents{
        let new = String(char)
        finalComponents.append(new)
    }
    
    finalComponents.append("oz")
    
    return finalComponents
}
convertToGrams(3.5)

convertToOunces(75.0)





