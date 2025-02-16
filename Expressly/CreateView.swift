//
//  CreateView.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI

struct CreateView: View {
    @Binding var showExpressionCreator: Bool
    @Binding var newExpression: Expression
    
    var body: some View {
        NavigationStack {
            Group {
                if UIDevice.isIPhone {
                    iPhoneCreateView(showExpressionCreator: $showExpressionCreator, newExpression: $newExpression)
                } else {
                    iPadCreateView(showExpressionCreator: $showExpressionCreator, newExpression: $newExpression)
                }
            }
            .navigationTitle(Text("Create Expression"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct iPhoneCreateView: View {
    @Binding var showExpressionCreator: Bool
    @Binding var newExpression: Expression
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                GuidedPromptCreate(showExpressionCreator: $showExpressionCreator, newExpression: $newExpression)
                FreeformCreate(showExpressionCreator: $showExpressionCreator, newExpression: $newExpression)
            }
            .padding(.horizontal)
        }
        .clipped()
    }
}

struct iPadCreateView: View {
    @Binding var showExpressionCreator: Bool
    @Binding var newExpression: Expression
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                GuidedPromptCreate(showExpressionCreator: $showExpressionCreator, newExpression: $newExpression)
                FreeformCreate(showExpressionCreator: $showExpressionCreator, newExpression: $newExpression)
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
    struct Preview: View {
        @State var showExpressionCreator = false
        @State var newExpression = Expression()
        var body: some View {
            CreateView(showExpressionCreator: $showExpressionCreator, newExpression: $newExpression)
        }
    }
    return Preview()
}
