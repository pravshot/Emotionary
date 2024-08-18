//
//  ExpressionGridItem.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/16/24.
//

import SwiftUI

struct ExpressionGridItem: View {
    var expression: Expression
    
    var body: some View {
        Image(uiImage: expression.getUIImage())
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .clipShape(.rect(cornerRadius: 8))
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray, lineWidth: 1)
            }
            .overlay(alignment: .bottomTrailing) {
                Image(expression.emotion!.icon)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .offset(x: -2, y: -2)
            }
    }
}

#Preview {
    ExpressionGridItem(expression: Expression(
        drawing: UIImage(systemName: "flame")?.pngData() ?? Data(),
        emotion: Emotion.happy
    ))
}
