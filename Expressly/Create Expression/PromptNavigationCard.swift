//
//  PromptCard.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI

struct PromptNavigationCard: View {
    var prompt: String
    
    var body: some View {
        GroupBox {
            HStack {
                Text(prompt)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
                
            }
        }
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            PromptNavigationCard(prompt: Prompt.random())
        }
    }
    return Preview()
}
