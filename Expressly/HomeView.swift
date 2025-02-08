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
            Group {
                if UIDevice.isIPhone {
                    iPhoneHomeView(navPath: $navPath)
                } else {
                    iPadHomeView(navPath: $navPath)
                }
            }
            .navigationTitle(Text("Welcome back"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct iPhoneHomeView: View {
    @Binding var navPath: [NavPath]
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                NewExpression(path: $navPath)
                DailyStreak()
                RecentEmotions()
                AllEmotions()
            }
            .padding(.horizontal)
        }
        .clipped()
    }
}

struct iPadHomeView: View {
    @Binding var navPath: [NavPath]
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                VStack(spacing: 16) {
                    NewExpression(path: $navPath)
                    RecentEmotions()
                }
                VStack(spacing: 16) {
                    DailyStreak()
                    AllEmotions()
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var isPortrait: Bool {
        UIDevice.current.orientation.isPortrait
    }
    
    static var isLandscape: Bool {
        UIDevice.current.orientation.isLandscape
    }
}

#Preview {
    return HomeView()
}
