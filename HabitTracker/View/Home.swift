//
//  Home.swift
//  HabitTracker
//
//  Created by Nathan Foo on 5/15/25.
//

import SwiftUI
import SwiftData

struct Home: View {
    @AppStorage("username") private var username: String = ""
    @Query(sort: [.init(\Habit.createdAt, order: .reverse)], animation: .snappy) private var habits: [Habit]
    @Namespace private var animationID
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                HeaderView()
                    .padding(.bottom, 15)
                
                ForEach(habits) { habit in
                    HabitCardView(animationID: animationID, habit: habit)
                }
            }
            .padding(15)
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
        .overlay {
            if habits.isEmpty {
                ContentUnavailableView("Start tracking your habits", systemImage: "checkmark.seal.fill")
                    .offset(y: 20)
            }
        }
        .safeAreaInset(edge: .bottom) {
            CreateButton()
        }
        .background {
            Rectangle()
                .fill(.primary.opacity(0.05))
                .ignoresSafeArea()
                .scaleEffect(1.5)
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Welcome back, \(username)!")
                .font(.title.bold())
                .lineLimit(1)
        }
        .hSpacing(.leading)
    }
    
    @ViewBuilder
    func CreateButton() -> some View {
        NavigationLink {
            HabitCreationView()
                .navigationTransition(.zoom(sourceID: "CREATEBUTTON", in: animationID))
        } label: {
            HStack(spacing: 10) {
                Text("Create Habit")
                Image(systemName: "plus.circle.fill")
            }
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(.green.gradient, in: .capsule)
            .matchedTransitionSource(id: "CREATEBUTTON", in: animationID)
        }
        .hSpacing(.center)
        .padding(.vertical, 10)
        .background {
            Rectangle()
                .fill(.background)
                .mask {
                    Rectangle()
                        .fill(.linearGradient(colors: [
                            .white.opacity(0),
                            .white.opacity(0.5),
                            .white,
                            .white
                        ], startPoint: .top, endPoint: .bottom))
                }
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
