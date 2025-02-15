//
//  HomeView.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI

struct HomeView: View {
    @State var navPath: [NavPath] = []
    @State var newExpression = Expression()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            Group {
                if UIDevice.isIPhone {
                    iPhoneHomeView(navPath: $navPath, newExpression: $newExpression)
                } else {
                    iPadHomeView(navPath: $navPath, newExpression: $newExpression)
                }
            }
            .navigationTitle(Text("Create Expression"))
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: NavPath.self) {pathValue in
                switch pathValue {
                case NavPath.DrawExpression:
                    DrawExpression(path: $navPath, expression: newExpression)
                        .toolbar(.hidden, for: .tabBar)
                case NavPath.ExpressionForm:
                    ExpressionForm(path: $navPath, expression: $newExpression)
                        .toolbar(.hidden, for: .tabBar)
                }
            }
        }
    }
}

struct iPhoneHomeView: View {
    @Binding var navPath: [NavPath]
    @Binding var newExpression: Expression
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
//                NewExpression(path: $navPath)
                GuidedPromptCreate(path: $navPath, newExpression: $newExpression)
                FreeformCreate(path: $navPath, newExpression: $newExpression)
            }
            .padding(.horizontal)
        }
        .clipped()
    }
}

struct iPadHomeView: View {
    @Binding var navPath: [NavPath]
    @Binding var newExpression: Expression
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                GuidedPromptCreate(path: $navPath, newExpression: $newExpression)
                FreeformCreate(path: $navPath, newExpression: $newExpression)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

enum NavPath: String {
    case DrawExpression = "DrawExpression"
    case ExpressionForm = "ExpressionForm"
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
