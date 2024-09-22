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
            if UIDevice.isIPhone {
                iPhoneHomeView(navPath: $navPath)
            } else {
                iPadHomeView(navPath: $navPath)
            }
        }
    }
}

struct iPhoneHomeView: View {
    @Binding var navPath: [NavPath]
    var body: some View {
        ScrollView {
            VStack {
                TabTitle(text: "Welcome back")
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
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    var body: some View {
        VStack {
            TabTitle(text: "Welcome back")
            HStack(alignment: .top) {
                VStack {
                    NewExpression(path: $navPath)
                    RecentEmotions()
                }
                VStack {
                    DailyStreak()
                    AllEmotions()
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct TabTitle: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
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
