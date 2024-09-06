//
//  ExpressionPrompt.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI

struct ExpressionPrompt: View {
    var prompt: String
    
    var body: some View {
        GroupBox {
            HStack {
                Text(prompt)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
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
