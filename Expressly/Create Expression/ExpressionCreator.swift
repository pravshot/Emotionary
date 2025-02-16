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
    
    func returnToHome() {
        expression = Expression()
        isPresented = false
    }
    
    var body: some View {
        NavigationStack(path: $navPath) {
            Group {
                DrawExpression(expression: $expression, path: $navPath, returnToHome: returnToHome)
            }
            .navigationDestination(for: String.self) { _ in
                ExpressionForm(expression: $expression, path: $navPath, returnToHome: returnToHome)
            }
        }
        // once overlay is fully gone, clear the nav stack
        .onDisappear {
            withTransaction(Transaction(animation: nil)) {
                navPath.removeAll()
            }
        }
    }
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
