//
//  TrendsView.swift
//  Expressly
//
//  Created by Praveen Kalva on 2/14/25.
//

import SwiftUI

struct TrendsView: View {
    var body: some View {
        NavigationStack {
            Group {
                if UIDevice.isIPhone {
                    iPhoneTrendsView()
                } else {
                    iPadTrendsView()
                }
            }
            .navigationTitle(Text("Trends"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct iPhoneTrendsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                DailyStreak()
                RecentEmotions()
                AllEmotions()
            }
            .padding(.horizontal)
        }
        .clipped()
    }
}

struct iPadTrendsView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                VStack(spacing: 16) {
                    DailyStreak()
                    RecentEmotions()
                }
                AllEmotions()
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    TrendsView()
}
