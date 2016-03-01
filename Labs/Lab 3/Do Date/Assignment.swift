//
//  Assignment.swift
//  Do Date
//
//  Created by Matt Dickey on 2/14/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class Assignment: Object {
    
    dynamic var name = ""
    dynamic var subject = ""
    dynamic var dueDate = NSDate()
    
    dynamic var isCompleted = false
    dynamic var isLongTerm = false
    dynamic var isMidTerm = false
    dynamic var isShortTerm = false

    
    func isOverDue() -> Bool{
        return (NSDate().compare(self.dueDate) == NSComparisonResult.OrderedDescending)
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
