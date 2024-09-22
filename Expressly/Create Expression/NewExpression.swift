//
//  CreateExpression.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI
import SwiftData

struct NewExpression: View {
    static var fetchDescriptor: FetchDescriptor<Expression> {
        var descriptor = FetchDescriptor<Expression>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        descriptor.fetchLimit = 1
        return descriptor
    }
    @Query(NewExpression.fetchDescriptor) private var lastExpression: [Expression]
    var lastPrompt: String {
        return !lastExpression.isEmpty ? lastExpression[0].prompt : ""
    }
    
    @Binding var path: [NavPath]
    @State var newExpression = Expression()
    
    var body: some View {
        GroupBox {
            PromptNavigationCard(expression: newExpression, prompt: Prompt.random(exclude: lastPrompt), path: $path)
                .id(lastPrompt)
            PromptNavigationCard(expression: newExpression, prompt: Prompt.freestyleMessage, path: $path)
        } label: {
            Text("Create New Expression")
                .font(.headline)
        }
        .navigationDestination(for: NavPath.self) {pathValue in
            switch pathValue {
            case NavPath.DrawExpression:
                DrawExpression(path: $path, expression: newExpression)
                    .toolbar(.hidden, for: .tabBar)
            case NavPath.ExpressionForm:
                ExpressionForm(path: $path, expression: $newExpression)
                    .toolbar(.hidden, for: .tabBar)
            }
        }
            
    }
}

enum NavPath: String {
    case DrawExpression = "DrawExpression"
    case ExpressionForm = "ExpressionForm"
}

#Preview {
    struct Preview: View {
        @State var navPath: [NavPath] = []
        var body: some View {
            NewExpression(path: $navPath)
        }
    }
    return Preview()
}
