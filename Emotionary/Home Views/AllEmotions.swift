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
                    ForEach(Emotion.allCases) {emotion in
                        BarMark(
                            x: .value("Emotion", emotion.icon),
                            y: .value("Count", emotionCounts[emotion] ?? 0)
                        )
                        .cornerRadius(barCornerRadius)
                        .foregroundStyle(emotion.color)
                    }
                }
                .overlay {
                    if emotionCounts.isEmpty {
                        Text("No data")
                            .font(.title2)
                            .foregroundStyle(.gray)
                    }
                }
                .chartXAxis {
                    if !emotionCounts.isEmpty {
                        AxisMarks(values: .automatic(desiredCount: 3)) {
                            AxisGridLine()
                        }
                    }
                }
                .chartYAxis {
                    if !emotionCounts.isEmpty {
                        AxisMarks(values: .automatic(desiredCount: 3)) {
                            AxisGridLine()
                        }
                    }
                }
                .frame(maxHeight: UIDevice.isIPhone ? 150 : 280)
                
                if !emotionCounts.isEmpty {
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
            }
        } label: {
            Text("All Emotions")
                .font(.headline)
        }
    }
}

#Preview {
    AllEmotions()
}
