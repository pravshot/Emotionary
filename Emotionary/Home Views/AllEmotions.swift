//
//  All Emotions.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI
import Charts

struct AllEmotions: View {
    var emotionCounts: [Emotion: Int]
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
                .frame(minHeight: 200, maxHeight: 225)
                
                HStack {
                    ForEach(Emotion.allCases) { emotion in
                        Spacer()
                        Image(emotion.icon)
                            .resizable()
                            .frame(width: 40, height: 40)
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
    AllEmotions(emotionCounts: [
        .sad: 3,
        .upset: 5,
        .neutral: 2,
        .content: 1,
        .happy: 5
    ])
}
