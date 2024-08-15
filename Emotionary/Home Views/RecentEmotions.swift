//
//  RecentEmotions.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI
import Charts

struct RecentEmotions: View {
    var emotions: [Emotion]
    
    var body: some View {
        GroupBox {
            Chart {
                ForEach(emotions.indices, id: \.self) { index in
                    LineMark(
                        x: .value("History", index),
                        y: .value("Mood", emotions[index].rawValue)
                    )
                    PointMark(
                        x: .value("History", index),
                        y: .value("Mood", emotions[index].rawValue)
                    )
                    .foregroundStyle(.accent)
                }
            }
            .frame(maxHeight: 200)
            
        } label: {
            Text("Your Recent Emotions")
                .font(.headline)
        }
    }
}

#Preview {
    RecentEmotions(emotions: [.upset, .content, .neutral, .happy, .neutral, .sad])
}
