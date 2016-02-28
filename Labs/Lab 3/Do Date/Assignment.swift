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
    
    func fireNotification() {
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        if settings!.types == .None {
            let ac = UIAlertController(title: "Can't schedule", message: "Either we don't have permission to schedule notifications, or we haven't asked yet.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            return
        }
        
        let notification = UILocalNotification()
        notification.alertBody = "\(name) is due \(dueDate)!"
        notification.alertAction = "Okay"
        
    }

    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
