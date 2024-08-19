//
//  HomeView.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Welcome back")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                NewExpression()
                DailyStreak()
                RecentEmotions()
                AllEmotions()
            }
            .frame(height: nil)
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
