//
//  ExpressionPrompt.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI

struct ExpressionPrompt: View {
    @Binding var prompt: String
    
    var body: some View {
        GroupBox {
            HStack {
                Text(prompt)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                Spacer()
                if (prompt != Prompt.freestyleMessage) {
                    Button {
                        prompt = Prompt.random(exclude: prompt)
                    } label: {
                        Image(systemName: "shuffle.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    Button {
                        prompt = Prompt.freestyleMessage
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                } else {
                    Button {
                        prompt = Prompt.random()
                    } label: {
                        Label("Prompt", systemImage: "plus")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 7)
                            .background(Capsule(style: .circular))
                    }
                }
            }
        }
    }
}

#Preview {
    struct PreviewView: View {
        @State var prompt: String
        var body: some View {
            ExpressionPrompt(prompt: $prompt)
        }
    }
    return PreviewView(prompt: Prompt.freestyleMessage)
}
