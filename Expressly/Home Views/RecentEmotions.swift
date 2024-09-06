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
        descriptor.fetchLimit = 5
        return descriptor
    }
    @Query(RecentEmotions.fetchDescriptor) private var recentExpressions: [Expression]
    var emotions: [Emotion] {
        return recentExpressions.reversed().map({ $0.emotion! })
    }

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
                            .frame(width: 32, height: 32)
                    }
                }
            }
            .overlay {
                if emotions.isEmpty {
                    Text("No data")
                        .font(.title2)
                        .foregroundStyle(.gray)
                }
            }
            .chartXAxis {
                if !emotions.isEmpty {
                    AxisMarks(values: .automatic(desiredCount: 5)) {
                        AxisGridLine()
                    }
                }
            }
            .chartYAxis {
                if !emotions.isEmpty {
                    AxisMarks(values: .automatic(desiredCount: 5)) {
                        AxisGridLine()
                    }
                }
            }
            .chartXScale(range: .plotDimension(padding: 16))
            .chartYScale(domain: 0.5...5.5)
            .frame(minHeight: UIDevice.isIPhone ? 180 : 0,
                   maxHeight: UIDevice.isIPhone ? 180 : 300)
            
        } label: {
            Text("Recent Emotions")
                .font(.headline)
        }
    }
}


#Preview {
    return RecentEmotions()
}
