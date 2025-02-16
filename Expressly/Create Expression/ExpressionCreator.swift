//
//  ExpressionCreator.swift
//  Expressly
//
//  Created by Praveen Kalva on 2/15/25.
//

import SwiftUI

struct ExpressionCreator: View {
    @State var navPath: [String] = []
    @Binding var isPresented: Bool
    @Binding var expression: Expression
    
    var body: some View {
        NavigationStack(path: $navPath) {
            Group {
                DrawExpression(expression: $expression, path: $navPath, returnToHome: {isPresented = false})
            }
//            .navigationTitle("New Expression")
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarBackButtonHidden()
            .navigationDestination(for: String.self) { _ in
                ExpressionForm(expression: $expression, path: $navPath, returnToHome: {isPresented = false})
            }
        }
    }
}

enum CreationStep {
    case draw
    case form
}

#Preview {
    struct Preview: View {
        @State var expression = Expression()
        @State var isPresented: Bool = false
        var body: some View {
            ExpressionCreator(isPresented: $isPresented, expression: $expression)
        }
    }
    return Preview()
}
