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
    var emotionOverlaySize: CGFloat {
        return UIDevice.isIPhone ? 32 : 48
    }
    
    var body: some View {
        GeometryReader { geometry in
            Image(uiImage: expressionImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.width)
                .clipped()
                .clipShape(.rect(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                )
                .overlay(alignment: .bottomTrailing) {
                    Image(expression.emotion!.icon)
                        .resizable()
                        .frame(width: emotionOverlaySize, height: emotionOverlaySize)
                        .offset(x: -3, y: -3)
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
