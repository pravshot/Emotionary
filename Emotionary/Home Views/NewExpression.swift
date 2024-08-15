//
//  CreateExpression.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI

struct NewExpression: View {
    var isTodaysExpression: Bool
    
    var body: some View {
        GroupBox {
            PromptCard(prompt: Prompt.random())
            PromptCard(prompt: Prompt.freestyleMessage)
        } label: {
            Text(isTodaysExpression ? "Today's Expression" : "Create New Expression")
                .font(.headline)
        }
        
    }
}

#Preview {
    NewExpression(isTodaysExpression: true)
}
