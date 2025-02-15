//
//  GuidedPromptCreate.swift
//  Expressly
//
//  Created by Praveen Kalva on 2/15/25.
//

import SwiftUI

struct GuidedPromptCreate: View {
    @Binding var path: [NavPath]
    @Binding var newExpression: Expression
    @State var prompts: [String] = Prompt.randomK(k: 3)
    
    var body: some View {
        GroupBox {
            PromptNavigationCard(prompt: prompts[0])
                .onTapGesture {
                    newExpression.prompt = prompts[0]
                    path.append(.DrawExpression)
                }
            PromptNavigationCard(prompt: prompts[1])
                .onTapGesture {
                    newExpression.prompt = prompts[1]
                    path.append(.DrawExpression)
                }
            PromptNavigationCard(prompt: prompts[2])
                .onTapGesture {
                    newExpression.prompt = prompts[2]
                    path.append(.DrawExpression)
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
        @State var navPath: [NavPath] = []
        @State var expression = Expression()
        var body: some View {
            GuidedPromptCreate(path: $navPath, newExpression: $expression)
        }
    }
    return Preview()
}
