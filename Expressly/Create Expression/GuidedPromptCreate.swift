//
//  GuidedPromptCreate.swift
//  Expressly
//
//  Created by Praveen Kalva on 2/15/25.
//

import SwiftUI

struct GuidedPromptCreate: View {
    @Binding var showExpressionCreator: Bool
    @Binding var newExpression: Expression
    @State var prompts: [String] = Prompt.randomK(k: 3)
    
    var body: some View {
        GroupBox {
            ForEach(prompts, id: \.self) { prompt in
                PromptNavigationCard(prompt: prompt)
                    .onTapGesture {
                        newExpression.prompt = prompt
                        showExpressionCreator = true
                    }
            }
        } label: {
            HStack {
                Label("Guided Prompts", systemImage: "scribble.variable")
                    .font(.headline)
                    .foregroundStyle(.accent)
                Spacer()
                Button {
                    withAnimation(.snappy) {
                        prompts = Prompt.randomK(k: 3, exclude: prompts)
                    }
                } label: {
                    Image(systemName: "shuffle.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
                
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var showExpressionCreator = false
        @State var expression = Expression()
        var body: some View {
            GuidedPromptCreate(showExpressionCreator: $showExpressionCreator, newExpression: $expression)
        }
    }
    return Preview()
}
