//
//  All Emotions.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI
import SwiftData
import Charts

struct AllEmotions: View {
    @Query private var expressions: [Expression]
    var emotionCounts: [Emotion: Int] {
        var counts: [Emotion: Int] = [:]
        for expression in expressions {
            counts[expression.emotion!, default: 0] += 1
        }
        return counts
    }
    let barCornerRadius = 10.0
    
    var body: some View {
        GroupBox {
            VStack {
                Chart {
                    BarMark(
                        x: .value("Emotion", Emotion.sad.icon),
                        y: .value("Count", emotionCounts[.sad] ?? 0)
                    )
                    .cornerRadius(barCornerRadius)
                    .foregroundStyle(Emotion.sad.color)
                    BarMark(
                        x: .value("Emotion", Emotion.upset.icon),
                        y: .value("Count", emotionCounts[.upset] ?? 0)
                    )
                    .cornerRadius(barCornerRadius)
                    .foregroundStyle(Emotion.upset.color)
                    BarMark(
                        x: .value("Emotion", Emotion.neutral.icon),
                        y: .value("Count", emotionCounts[.neutral] ?? 0)
                    )
                    .cornerRadius(barCornerRadius)
                    .foregroundStyle(Emotion.neutral.color)
                    BarMark(
                        x: .value("Emotion", Emotion.content.icon),
                        y: .value("Count", emotionCounts[.content] ?? 0)
                    )
                    .cornerRadius(barCornerRadius)
                    .foregroundStyle(Emotion.content.color)
                    BarMark(
                        x: .value("Emotion", Emotion.happy.icon),
                        y: .value("Count", emotionCounts[.happy] ?? 0)
                    )
                    .cornerRadius(barCornerRadius)
                    .foregroundStyle(Emotion.happy.color)
                }
                .chartXAxis(.hidden)
                .chartYAxis {
                    AxisMarks(values: .automatic(desiredCount: 3)) {
                        AxisGridLine()
                    }
                }
                .frame(height: 150)
                
                HStack {
                    ForEach(Emotion.allCases) { emotion in
                        Spacer()
                        Image(emotion.icon)
                            .resizable()
                            .frame(width: 32, height: 32)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
        } label: {
            Text("All Emotions")
                .font(.headline)
        }
    }
}

#Preview {
    AllEmotions()
}
