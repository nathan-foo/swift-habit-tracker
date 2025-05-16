//
//  Home.swift
//  HabitTracker
//
//  Created by Nathan Foo on 5/15/25.
//

import SwiftUI

struct Home: View {
    @AppStorage("username") private var username: String = ""
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                HeaderView()
            }
            .padding(15)
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
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
}

#Preview {
    Home()
}
