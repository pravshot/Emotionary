//
//  RecentEmotions.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI
import SwiftData
import Charts

struct RecentEmotions: View {
    static var fetchDescriptor: FetchDescriptor<Expression> {
        var descriptor = FetchDescriptor<Expression>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        descriptor.fetchLimit = 6
        return descriptor
    }
    @Query(RecentEmotions.fetchDescriptor) private var recentExpressions: [Expression]
    var emotions: [Emotion]
    
    var body: some View {
        GroupBox {
            Chart {
                ForEach(emotions.indices, id: \.self) { index in
                    LineMark(
                        x: .value("History", index),
                        y: .value("Mood", emotions[index].rawValue)
                    )
                    .foregroundStyle(.gray)
                    PointMark(
                        x: .value("History", index),
                        y: .value("Mood", emotions[index].rawValue)
                    )
                    .symbol {
                        Image(emotions[index].icon)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .foregroundStyle(.accent)
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis {
                AxisMarks() {
                    AxisGridLine()
                }
            }
            .frame(minHeight: 150, maxHeight: 200)
            .padding(.horizontal)
            
        } label: {
            Text("Recent Emotions")
                .font(.headline)
        }
    }
}


#Preview {
    RecentEmotions(emotions: [.upset, .content, .neutral, .happy, .sad])
}
