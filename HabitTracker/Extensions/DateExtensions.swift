//
//  DateExtensions.swift
//  HabitTracker
//
//  Created by Nathan Foo on 5/16/25.
//

import SwiftUI

extension Date {
    var weekDay: String {
        let calendar = Calendar.current
        let weekDay = calendar.weekdaySymbols[calendar.component(.weekday, from: self) - 1]
        return weekDay
    }
    
    var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self)
    }
    
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    static var startDateOfThisMonth: Date {
        let calendar = Calendar.current
        guard let date = calendar.date(from: calendar.dateComponents([.year, .month], from: .now)) else {
            fatalError("Cannot retrieve start date of this month")
        }
        return date
    }
    
    static var datesInThisMonth: [Date] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: .now) else {
            fatalError("Cannot retrieve dates in this month")
        }
        return range.compactMap {
            calendar.date(byAdding: .day, value: $0 - 1, to: startDateOfThisMonth)
        }
    }
}
