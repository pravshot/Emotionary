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
                ZStack {
                    Circle()
                        .foregroundStyle(.accent)
                    Text(String(streak))
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white)
                }
                Text("day streak")
            }
            .frame(maxHeight: 100)
            
        } label: {
            Text("Daily Streak")
                .font(.headline)
        }
    }
}

#Preview {
    DailyStreak(streak: 50)
}
