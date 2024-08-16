//
//  PromptCard.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI

struct PromptNavigationCard: View {
    @State var navPath: [NavPath] = []
    @State var expression: Expression
    
    var isTodaysExpression: Bool
    
    var body: some View {
        NavigationStack(path: $navPath) {
            GroupBox {
                HStack {
                    Text(expression.prompt)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: 250, alignment: .leading)
                    Spacer()
                    if (expression.prompt != Prompt.freestyleMessage) {
                        Button {
                            expression.prompt = Prompt.random(exclude: expression.prompt)
                        } label: {
                            Image(systemName: "shuffle.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    NavigationLink(value: NavPath.DrawExpression) {
                        Image(systemName: "arrowshape.forward.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .navigationDestination(for: NavPath.self) {pathValue in
                        switch pathValue {
                            case NavPath.DrawExpression:
                                DrawExpression(path: $navPath, expression: $expression, isTodaysExpression: isTodaysExpression)
                            case NavPath.ExpressionForm:
                                ExpressionForm(path: $navPath, expression: $expression, isTodaysExpression: isTodaysExpression)
                        }
                    }
                }
            }
        }
        
    }
}

enum NavPath: String {
    case DrawExpression = "DrawExpression"
    case ExpressionForm = "ExpressionForm"
}

#Preview {
    return PromptNavigationCard(expression: Expression(), isTodaysExpression: true)
}
