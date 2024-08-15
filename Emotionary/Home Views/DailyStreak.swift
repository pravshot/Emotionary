//
//  DailyStreak.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI

struct DailyStreak: View {
    
    var streak: Int
    
    var body: some View {
        GroupBox {
            HStack {
                GroupBox {
                    VStack {
                        Image(streak > 0 ? Emotion.happy.icon : Emotion.sad.icon)
                            .resizable()
                            .scaledToFit()
                        Spacer()
                        Text(String(streak))
                            .font(.title)
                            .foregroundStyle(.white)
                            .bold()
                        Text(streak == 1 ? "day" : "days")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                    }
                }
                .backgroundStyle(Emotion.happy.color)
                GroupBox {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                }
            }
            .frame(maxHeight: 150)
            
        } label: {
            Text("Daily Streak")
                .font(.headline)
        }
    }
}

#Preview {
    DailyStreak(streak: 40)
}
