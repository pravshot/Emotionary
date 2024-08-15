//
//  HomeView.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI

struct HomeView: View {
    @State var activeScreen: Screen = .home
    
    var emotions: [Emotion] = [.upset, .content, .neutral, .happy, .sad]
    var emotionCounts: [Emotion: Int] = [
        .sad: 3,
        .upset: 5,
        .neutral: 2,
        .content: 1,
        .happy: 5
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Welcome back")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                NewExpression(isTodaysExpression: true)
                DailyStreak(streak: 50)
                RecentEmotions(emotions: emotions)
                AllEmotions(emotionCounts: emotionCounts)
            }
            .frame(height: nil)
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
