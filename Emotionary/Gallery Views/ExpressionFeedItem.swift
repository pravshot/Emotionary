//
//  ExpressionFeedItem.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/17/24.
//

import SwiftUI

struct ExpressionFeedItem: View {
    var expression: Expression
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                GroupBox {
                    Text(expression.prompt)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                GroupBox {
                    Image(uiImage: expression.getUIImage())
                        .resizable()
                        .scaledToFit()
                }
                HStack(alignment: .top, spacing: 10) {
                    Text(expression.title)
                        .font(.title2)
                        .bold()
                    Spacer()
                    ShareLink(
                        item: Image(uiImage: expression.getUIImage()),
                        preview: SharePreview(
                            expression.title,
                            image: Image(uiImage: expression.getUIImage())
                        )
                    ) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 25)
                    }
                    Button {
                        expression.favorite.toggle()
                    } label: {
                        Image(systemName: expression.favorite ? "star.fill" : "star")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 25)
                    }
                    Image(expression.emotion!.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28)
                }
                Text(expression.caption)
                    .font(.callout)
                Text(expression.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    struct Preview: View {
        var expression = Expression(
            drawing: UIImage(systemName: "flame")?.pngData() ?? Data(),
            emotion: Emotion.happy,
            title: "Flame",
            caption: "What a hot day outside!",
            date: Date(),
            favorite: false
        )
        
        var body: some View {
            ExpressionFeedItem(expression: expression)
        }
    }
    return Preview()
}
