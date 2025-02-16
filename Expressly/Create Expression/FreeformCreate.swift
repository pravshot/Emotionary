//
//  FreeformCreate.swift
//  Expressly
//
//  Created by Praveen Kalva on 2/15/25.
//

import SwiftUI

struct FreeformCreate: View {
    @Binding var showExpressionCreator: Bool
    @Binding var newExpression: Expression
    
    var body: some View {
        GroupBox {
            PromptNavigationCard(prompt: Prompt.freestyleMessage)
                .onTapGesture {
                    newExpression.prompt = Prompt.freestyleMessage
                    showExpressionCreator = true
                }
        } label: {
            Label("Freeform", systemImage: "scribble.variable")
                .font(.headline)
                .foregroundStyle(.accent)
        }
    }
}

#Preview {
    struct Preview: View {
        @State var showExpressionCreator = false
        @State var expression = Expression()
        var body: some View {
            FreeformCreate(showExpressionCreator: $showExpressionCreator, newExpression: $expression)
        }
    }
    return Preview()
}
