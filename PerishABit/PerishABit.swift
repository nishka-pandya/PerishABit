//
//  PerisHabitsApp.swift
//  PerisHabits
//
//  Created by Scholar on 6/22/26.
//

import SwiftUI
import SwiftData

@main
struct PerisHabitsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: FoodItemInfo.self)
                // Connects SwiftData and SwiftUI using the modifier and the FoodItemIndo model
        }
    }
}
