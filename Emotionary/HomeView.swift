//
//  HomeView.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI

struct HomeView: View {
    @State var navPath: [NavPath] = []
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ScrollView {
                VStack {
                    Text("Welcome back")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    NewExpression(path: $navPath)
                    DailyStreak()
                    RecentEmotions()
                    AllEmotions()
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    return HomeView()
}
