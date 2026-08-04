//
//  FoodItemInfo.swift
//  PerisHabits
//
//  Created by Scholar on 6/28/26.
//

import Foundation
import SwiftData

@Model // Macro that defines the structure of the data. Designed to be a data model that will interact with a persistent storage system that can handle data persistence, syncing, and observing changes. Signals the compiler to generate all the data stroage management code.
class FoodItemInfo{
    
    var name: String
    var useByDate: Date
    var quantity: Int
    var type: String
    
    init(name: String, useByDate: Date, quantity: Int, type: String, ){
        self.name = name
        self.useByDate = useByDate
        self.quantity = quantity
        self.type = type
        

    }
    
    
    
}
