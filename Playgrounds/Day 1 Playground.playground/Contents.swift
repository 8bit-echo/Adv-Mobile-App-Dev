import UIKit
import Foundation

var score: Int?

print("score is \(score)")

score = 80

print("score is \(score)")

if var unwrappedScore = score {
    print("score is \(unwrappedScore)")
}
let newScore : Int! = 100
print("score is \(newScore)")

func sayHello(){
    print("Hello Class")
}
sayHello()

func sayHelloToMe(firstname first: String, lastname last: String) {
    print("Hello \(first) \(last).")
}
sayHelloToMe(firstname: "Matt", lastname: "Dickey")


func sayWhy (firstname first: String, lastname last: String) ->String{
    return "Why you do dis, " + first + " " + last + "?!"
}

let unbelievable = sayWhy(firstname: "Mart", lastname: "Darkey")
print(unbelievable)

let names = ["Tim","Cari","Michael", "Kai"]

func backwards(s1: String, _ s2:String) -> Bool{
    return s1 > s2
}

var reversed = names.sort(backwards)


// Using a closure

//LONGHAND
reversed = names.sort({(s1:String, s2: String)-> Bool in return s1 > s2})
print(reversed)

//MEDIUMHAND
reversed = names.sort({s1,s2 in return s1 > s2})
print(reversed)

//SHORTHAND
reversed = names.sort({s1, s2 in s1 > s2})
print(reversed)

//SHORTESTHAND
reversed = names.sort({$0 > $1})
print(reversed)



//ENUMS

enum carType{
    case gas
    case electric
    case hybrid
}

var car = carType.electric
car = .hybrid




//TYPE CASTING

class Pet {
    var name : String
    init(name: String){
        self.name = name
    }
    
}

class Dog : Pet {
    var breed : String
    init(name: String, breed : String) {
        self.breed = breed
        super.init(name: name)
    }
}


class Fish : Pet {
    var species : String
    init (name: String, species: String){
        self.species = species
        super.init(name: name)
    }
    
}


let myPets = [
    Dog(name: "Cole", breed: "Black Lab"),
    Dog(name: "Nikki", breed: "German Shepard"),
    Fish(name: "Nemo", species: "Clown Fish")
]


var dogCount = 0
var fishCount = 0

for pet in myPets {
    if pet is Dog{
        ++dogCount
        }
    else if pet is Fish {
            ++fishCount
        }
    }

print("I have \(dogCount) dogs and \(fishCount) fishes.")


for pet in myPets {
    if let dog = pet as? Dog {
        print("\(dog.name) is a \(dog.breed)")
    }else if let fish = pet as? Fish {
        print("\(fish.name) is a \(fish.species)")
    }
    
}










