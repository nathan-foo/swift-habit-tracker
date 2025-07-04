//
//  HabitCardView.swift
//  HabitTracker
//
//  Created by Nathan Foo on 5/16/25.
//

import SwiftUI

struct HabitCardView: View {
    var animationID: Namespace.ID
    var habit: Habit
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(habit.name)
                        .font(.callout)
                    
                    Text("Created on " + habit.createdAt.format("MM dd, YYYY"))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    Spacer(minLength: 0)
                    
                    CompletionProgressIndicator()
                }
            }
            
            HabitCalendarView(
                createdAt: habit.createdAt,
                frequencies: habit.frequencies,
                completedDates: habit.completedDates
            )
            .applyPaddedBackground(10)
            .matchedTransitionSource(id: habit.uniqueID, in: animationID)
        }
    }
    
    @ViewBuilder
    func CompletionProgressIndicator() -> some View {
        let habitMatchingDatesInThisMonth = Date.datesInThisMonth.filter { date in
            habit.frequencies.contains {
                $0.rawValue == date.weekDay
            } && date.startOfDay >= habit.createdAt.startOfDay
        }
        
        let habitsCompletedInThisMonth = habitMatchingDatesInThisMonth.filter {
            habit.completedDates.contains($0.timeIntervalSince1970)
        }
        
        let progress = CGFloat(habitsCompletedInThisMonth.count) / CGFloat(habitMatchingDatesInThisMonth.count)
        
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .stroke(.fill, lineWidth: 3)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(.green.gradient, lineWidth: 3)
                    .rotationEffect(.init(degrees: -90))
            }
            .frame(width: 30, height: 30)
            
            Text("\(habitsCompletedInThisMonth.count)/\(habitMatchingDatesInThisMonth.count)")
                .font(.caption2)
                .foregroundStyle(.gray)
            
        }
    }
}

