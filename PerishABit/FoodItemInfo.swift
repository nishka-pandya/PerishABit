//
//  FoodItemInfo.swift
//  PerisHabits
//
//  Created by Scholar on 6/28/26.
//

import Foundation
import SwiftData

@Model
class FoodItemInfo{
    
    var name: String
    var useByDate: Date
    //var daysRemaining: Int
    var quantity: Int
    var type: String
    
    init(name: String, useByDate: Date, quantity: Int, type: String, ){
        self.name = name
        self.useByDate = useByDate
        self.quantity = quantity
        self.type = type
        //let calendar = Calendar.current
        //let startMidnight = calendar.startOfDay(for: Date.now)  // Used ChatGPT to learn how to convert from date to dateComponents
        //let endMidnight = calendar.startOfDay(for: useByDate)
        //let components = calendar.dateComponents([.day], from: startMidnight, to: endMidnight).day
        //self.daysRemaining = components!

    }
    
    /*func getDaysRemaining() -> Int{
        
        let calendar = Calendar.current
        let startMidnight = calendar.startOfDay(for: Date.now)
        let endMidnight = calendar.startOfDay(for: useByDate)
        let components = calendar.dateComponents([.day],  from: startMidnight, to: endMidnight).day
        
        daysRemaining = components!
        
        return daysRemaining
        
        
    }*/
    
    
    
    
    
    
}
