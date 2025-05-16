//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Nathan Foo on 5/15/25.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Habit.self)
        }
    }
}
