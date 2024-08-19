//
//  DailyStreak.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI
import SwiftData

struct DailyStreak: View {
    @Query(sort: \Expression.date, order: .reverse) private var expressions: [Expression]
    var streak: Int {
        if expressions.isEmpty {
            return 0
        }
        let calendar = Calendar.current
        if !calendar.isDateInToday(expressions[0].date) &&
           !calendar.isDateInYesterday(expressions[0].date) {
            return 0
        }
        var streak = 1
        for i in 1..<expressions.count {
            let prevDate = calendar.startOfDay(for: expressions[i-1].date)
            let currDate = calendar.startOfDay(for: expressions[i].date)
            // skip duplicate dates
            if prevDate == currDate {
                continue
            }
            // if currDate is one day before prevDate, increment streak
            // else the streak is broken
            if currDate == calendar.date(byAdding: .day, value: -1, to: prevDate) {
                streak += 1
            } else {
                break
            }
        }
        return streak
    }
    
    var streakColor: Color {
        return streak > 0 ? Emotion.happy.color : Emotion.sad.color
    }
    var streakIcon: String {
        return streak > 0 ? Emotion.happy.icon : Emotion.sad.icon
    }
    var streakShade: Color {
        let redShade = Color(red: 1.0, green: 0.541, blue: 0.251)
        let greenShade = Color(red: 0.659, green: 0.867, blue: 0.471)
        return streak > 0 ? greenShade : redShade
    }
    
    var body: some View {
        GroupBox {
            ZStack {
                Circle()
                    .stroke(
                        LinearGradient(colors: [streakColor, streakColor, streakShade],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing
                                      ),
                        lineWidth: 8
                    )
                    .frame(width: 140, height: 140)
                Image(streakIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .offset(y: -30)
                
                Text(String(streak))
                    .font(.system(size: 38))
                    .bold()
                    .foregroundStyle(streakColor)
                    .offset(y: 19)
                
                Text(streak == 1 ? "day" : "days")
                    .font(.title3)
                    .foregroundStyle(streakColor)
                    .offset(y: 45)
            }
            
        } label: {
            Text("Daily Streak")
                .font(.headline)
        }
    }
}

#Preview {
    DailyStreak()
}
