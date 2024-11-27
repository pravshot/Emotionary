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
                    .inset(by: 0.5)
                    .stroke(.gray.opacity(0.2), lineWidth: 1)
            }
            .overlay(alignment: .bottomTrailing) {
                Image(expression.emotion!.icon)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .offset(x: -2, y: -2)
            }
            .contextMenu {
                ShareLink(
                    item: Image(uiImage: expression.getUIImage()),
                    subject: Text(expression.title),
                    message: Text(expression.caption),
                    preview: SharePreview(
                        expression.title,
                        image: Image(uiImage: expression.getUIImage())
                    )
                ) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
    }
}

#Preview {
    ExpressionGridItem(expression: Expression(
        drawing: UIImage(systemName: "flame")?.pngData() ?? Data(),
        emotion: Emotion.happy
    ))
}
