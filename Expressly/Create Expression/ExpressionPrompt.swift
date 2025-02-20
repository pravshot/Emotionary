//
//  ExpressionPrompt.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI

struct ExpressionPrompt: View {
    @Environment(\.colorScheme) var colorScheme
    var prompt: String
    
    var body: some View {
        GroupBox {
            HStack {
                Text(prompt)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .backgroundStyle(Color(UIColor.secondarySystemGroupedBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(UIColor.systemGroupedBackground), lineWidth: 1)
        )
    }
}

#Preview {
    struct PreviewView: View {
        var prompt: String
        var body: some View {
            ExpressionPrompt(prompt: prompt)
        }
    }
    return PreviewView(prompt: Prompt.random())
}
