//
//  HabitCalendarView.swift
//  HabitTracker
//
//  Created by Nathan Foo on 5/16/25.
//

import SwiftUI

struct HabitCalendarView: View {
    var isDemo: Bool = false
    var createdAt: Date
    var frequencies: [Frequency]
    var completedDates: [TimeInterval]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 12) {
            if (!isDemo) {
                ForEach(Frequency.allCases, id: \.rawValue) { frequency in
                    Text(frequency.rawValue.prefix(3))
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            
            ForEach(0..<Date.startOffsetOfThisMonth, id: \.self) { _ in
                Circle()
                    .fill(.clear)
                    .frame(height: 30)
                    .hSpacing(.center)
            }
            
            ForEach(Date.datesInThisMonth, id: \.self) {date in
                let day = date.format("dd")
                
                Text(day)
                    .font(.caption)
                    .frame(height: 30)
                    .hSpacing(.center)
                    .background {
                        let isHabitCompleted = completedDates.contains {
                            $0 == date.timeIntervalSince1970
                        }
                        
                        let isHabitDay = frequencies.contains {
                            $0.rawValue == date.weekDay
                        } && date.startOfDay >= createdAt.startOfDay
                        
                        let isFutureHabit = isHabitDay && date.startOfDay > Date()
                        
                        if isHabitCompleted && isHabitDay && !isDemo {
                            Circle()
                                .fill(.green.tertiary)
                        } else if isHabitDay && !isFutureHabit && !isDemo {
                            Circle()
                                .fill(.red.tertiary)
                        } else if isHabitDay {
                            Circle()
                                .fill(.fill)
                        }
                    }
            }
        }
    }
}

#Preview {
    HabitCalendarView(createdAt: .now, frequencies: [.sunday, .wednesday, .saturday], completedDates: [])
}
