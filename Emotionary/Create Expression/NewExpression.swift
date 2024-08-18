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
    
    var body: some View {
        GroupBox {
            PromptNavigationCard(expression: Expression(prompt: Prompt.random()), isTodaysExpression: isTodaysExpression)
            PromptNavigationCard(expression: Expression(prompt: Prompt.freestyleMessage), isTodaysExpression: isTodaysExpression)
        } label: {
            Text(isTodaysExpression ? "Today's Expression" : "Create New Expression")
                .font(.headline)
        }
        
    }
}

#Preview {
    NewExpression()
}
