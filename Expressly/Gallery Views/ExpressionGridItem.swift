//
//  ExpressionGridItem.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/16/24.
//

import SwiftUI

struct ExpressionGridItem: View {
    @Environment(\.colorScheme) var colorScheme
    var expression: Expression
    
    var expressionImage: UIImage {
        expression.getUIImageWithBackground(colorScheme == .light ? .white : .black)
    }
    var shadowColor: Color {
        colorScheme == .light ? .black.opacity(0.25) : .white.opacity(0.75)
    }
    
    var body: some View {
        GeometryReader { geometry in
            Image(uiImage: expressionImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.width)
                .clipped()
                .clipShape(.rect(cornerRadius: 8))
                .shadow(color: shadowColor, radius: 2, x: 0, y: 1)
                .overlay(alignment: .bottomTrailing) {
                    Image(expression.emotion!.icon)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .offset(x: -2, y: -2)
                }
                .contextMenu {
                    ShareLink(
                        item: Image(uiImage: expressionImage),
                        subject: Text(expression.prompt),
                        message: Text(expression.caption),
                        preview: SharePreview(
                            "My Expression",
                            image: Image(uiImage: expressionImage)
                        )
                    ) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                }
        }.aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3),
              alignment: .center,
              spacing: 8) {
        ExpressionGridItem(expression: Expression(
            drawing: UIImage(systemName: "flame")?.pngData() ?? Data(),
            emotion: Emotion.happy
        ))
        ExpressionGridItem(expression: Expression(
            drawing: UIImage(systemName: "flame")?.pngData() ?? Data(),
            emotion: Emotion.happy
        ))
        ExpressionGridItem(expression: Expression(
            drawing: UIImage(systemName: "flame")?.pngData() ?? Data(),
            emotion: Emotion.happy
        ))
        ExpressionGridItem(expression: Expression(
            drawing: UIImage(systemName: "flame")?.pngData() ?? Data(),
            emotion: Emotion.happy
        ))
    }
    
}
