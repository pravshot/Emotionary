//
//  PromptCard.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI

struct PromptNavigationCard: View {
    var expression: Expression
    @State var prompt: String
    
    @Binding var path: [NavPath]
    
    var body: some View {
        GroupBox {
            HStack {
                Text(prompt)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                if (prompt != Prompt.freestyleMessage) {
                    Button {
                        prompt = Prompt.random(exclude: prompt)
                    } label: {
                        Image(systemName: "shuffle.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                }
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
                
            }
        }
        .onTapGesture {
            expression.prompt = prompt
            path.append(.DrawExpression)
        }
    }
}

#Preview {
    struct Preview: View {
        var expression = Expression()
        @State var navPath: [NavPath] = []
        var body: some View {
            PromptNavigationCard(expression: expression, prompt: Prompt.random(), path: $navPath)
        }
    }
    return Preview()
}
