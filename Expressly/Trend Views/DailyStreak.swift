//
//  DailyStreak.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI
import SwiftData

struct DailyStreak: View {
    @Environment(\.colorScheme) var colorScheme
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
        var icon = streak > 0 ? "streak-emotion" : "no-streak-emotion"
        if colorScheme == .dark { icon += "-dark" }
        return icon
    }
    var streakCircle: String {
        return streak > 0 ? "streak-circle" : "no-streak-circle"
    }
    
    var body: some View {
        GroupBox {
            VStack {
                ZStack {
                    Image(streakCircle)
                        .resizable()
                        .frame(width: 150, height: 150)
                    Image(streakIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
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
                .padding(.bottom, 8)
                
                HStack {
                    /*
                     Each iteration needs:
                     - date
                     - status: completed/missed/pending
                     */
                    ForEach(Array(getRecentStatuses(expressions).enumerated()), id: \.offset) 
                    {index, tuple in
                        let (date, status) = tuple
                        let (imageName, imageColor): (String, Color) = switch status {
                            case .Completed: ("checkmark.circle.fill", Emotion.happy.color)
                            case .Missed: ("xmark.circle.fill", Emotion.sad.color)
                            case .Pending: ("circle.dashed", Color.gray)
                        }
                        Spacer()
                        VStack {
                            Image(systemName: imageName)
                                .font(.title2)
                                .foregroundStyle(imageColor)
                            Text(date)
                                .font(.caption2)
                        }
                        Spacer()
                    }
                }
            }
            
        } label: {
            Label("Daily Streak", systemImage: "flame.fill")
                .font(.headline)
                .foregroundStyle(streakColor)
        }
    }
}

enum StreakStatus {
    case Completed
    case Missed
    case Pending
}

func getRecentStatuses(_ expressions: [Expression]) -> [(String, StreakStatus)] {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "E"
    var dateStreakMap: [Date: StreakStatus] = [:]
    // initialize with missed/pending
    let today = Date()
    let lastIndex = min(
        6,
        calendar.dateComponents(
            [.day],
            from: expressions.count > 0 ? expressions[expressions.count - 1].date : Date(),
            to: today
        ).day ?? 6
    )
    for i in 0...lastIndex {
        let prevDate = calendar.date(byAdding: .day, value: -i, to: today) ?? Date()
        dateStreakMap[calendar.startOfDay(for: prevDate)] = (prevDate == today) ? .Pending : .Missed
    }
    // fill in completed
    for expression in expressions {
        if expression.date < calendar.date(byAdding: .day, value: -6, to: today) ?? Date.distantPast {
            break
        }
        let key = calendar.startOfDay(for: expression.date)
        if dateStreakMap[key] != nil {
            dateStreakMap[key] = .Completed
        }
    }
    
    return Array(dateStreakMap)
        .sorted{ $0.0 < $1.0 } // sort by increasing date
        .map {
            (date, status) -> (String, StreakStatus) in
            (dateFormatter.string(from: date), status)
        } // format date as abbreviated string
}

#Preview {
    DailyStreak()
}
