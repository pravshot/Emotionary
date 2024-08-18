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
        var streak = 0
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
    DailyStreak()
}
