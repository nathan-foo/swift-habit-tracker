//
//  HabitCreationView.swift
//  HabitTracker
//
//  Created by Nathan Foo on 5/16/25.
//

import SwiftUI

struct HabitCreationView: View {
    @State private var name: String = ""
    @State private var frequencies: [Frequency] = []
    @State private var notificationDate: Date = Date()
    @State private var enableNotifications: Bool = false
    @State private var isNotificationPermissionGranted: Bool = false
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                TextField("My Habit", text: $name)
                    .font(.title)
                    .padding(.bottom, 10)
                
                Text("Habit Frequency")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.top, 5)
                
                HabitCalendarView(
                    isDemo: true,
                    createdAt: .now,
                    frequencies: frequencies,
                    completedDates: []
                )
                .applyPaddedBackground(15)
                
                FrequencyPicker()
                    .applyPaddedBackground(10)
                
                Text("Notifications")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.top, 5)
                
                NotificationProperties()
                
                HabitCreationButton()
            }
            .padding(15)
        }
        .animation(.snappy, value: enableNotifications)
        .background(.primary.opacity(0.05))
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    func FrequencyPicker() -> some View {
        HStack(spacing: 5) {
            ForEach(Frequency.allCases, id: \.rawValue) { frequency in
                Text(frequency.rawValue.prefix(3))
                    .font(.caption)
                    .hSpacing(.center)
                    .frame(height: 30)
                    .background {
                        if frequencies.contains(frequency) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.fill)
                        }
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            if frequencies.contains(frequency) {
                                frequencies.removeAll(where: { $0 == frequency })
                            } else {
                                frequencies.append(frequency)
                            }
                        }
                    }
            }
        }
    }
    
    @ViewBuilder
    func NotificationProperties() -> some View {
        Toggle("Enable Reminders", isOn: $enableNotifications)
            .font(.callout)
            .applyPaddedBackground(12)
            .disableWithOpacity(!isNotificationPermissionGranted)
        
        if enableNotifications && isNotificationPermissionGranted {
            DatePicker("Reminder Time", selection: $notificationDate, displayedComponents: [.hourAndMinute])
                .applyPaddedBackground(12)
                .transition(.blurReplace)
        }
    }
    
    @ViewBuilder
    func HabitCreationButton() -> some View {
        HStack(spacing: 10) {
            Button {
                
            } label: {
                HStack(spacing: 10) {
                    Text("Create Habit")
                    Image(systemName: "checkmark.circle.fill")
                }
                .fontWeight(.semibold)
                .hSpacing(.center)
                .foregroundStyle(.white)
                .padding(.vertical, 12)
                .background(.green.gradient, in: .rect(cornerRadius: 10))
                .contentShape(.rect)
            }
            .disableWithOpacity(habitValidation)
        }
    }
    
    var habitValidation: Bool {
        frequencies.isEmpty || name.isEmpty
    }
}

#Preview {
    HabitCreationView()
}
