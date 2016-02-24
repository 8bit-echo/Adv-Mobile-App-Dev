

import Foundation

class ToDoItem {
    var name : String
    var reminderDate: NSDate
    var id: String
    
    func overDue() -> Bool{
        return (NSDate().compare(self.reminderDate) == NSComparisonResult.OrderedDescending)
    }
    
    
    init(newName: String, newReminderDate: NSDate, newID : String){
        self.name = newName
        self.reminderDate = newReminderDate
        id = newID
    }
}