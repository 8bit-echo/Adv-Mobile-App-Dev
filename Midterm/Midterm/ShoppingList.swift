//
//  ShoppingList.swift
//  Midterm
//
//  Created by Matt Dickey on 3/10/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingList: Object {
    
    dynamic var storeName : String
    dynamic var items = [String]()
    
    
    init(store: String) {
        self.storeName = store
        super.init()
    }

    required init() {
        fatalError("init() has not been implemented")
    }



    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
