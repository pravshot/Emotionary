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
    var isTodaysExpression: Bool {
        return (lastExpression.isEmpty || !Calendar.current.isDateInToday(lastExpression[0].date))
    }
    
    @State var navPath: [NavPath] = []
    private var newExpression = Expression()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            GroupBox {
                PromptNavigationCard(expression: newExpression, prompt: Prompt.random(), path: $navPath)
                PromptNavigationCard(expression: newExpression, prompt: Prompt.freestyleMessage, path: $navPath)
            } label: {
                Text(isTodaysExpression ? "Today's Expression" : "Create New Expression")
                    .font(.headline)
            }
            .navigationDestination(for: NavPath.self) {pathValue in
                switch pathValue {
                case NavPath.DrawExpression:
                    DrawExpression(path: $navPath, expression: newExpression, isTodaysExpression: isTodaysExpression)
                case NavPath.ExpressionForm:
                    ExpressionForm(path: $navPath, expression: newExpression, isTodaysExpression: isTodaysExpression)
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
    NewExpression()
}
