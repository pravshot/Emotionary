//
//  PromptCard.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI

struct PromptNavigationCard: View {
    @State var prompt: String
    
    var body: some View {
        NavigationStack {
            GroupBox {
                HStack {
                    Text(prompt)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: 250, alignment: .leading)
                    Spacer()
                    if (prompt != Prompt.freestyleMessage) {
                        Button {
                            prompt = Prompt.random(exclude: prompt)
                        } label: {
                            Image(systemName: "shuffle.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    NavigationLink() {
                        DrawExpression(prompt: prompt)
                    } label: {
                        Image(systemName: "arrowshape.forward.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            }
        }
        
    }
}

#Preview {
    PromptNavigationCard(prompt: Prompt.random())
}
