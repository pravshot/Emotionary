//
//  ExpressionFeed.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/17/24.
//

import SwiftUI
import SwiftData

struct ExpressionFeed: View {
    var expressions: [Expression]
    var initialPosition: PersistentIdentifier
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack {
                    ForEach(expressions) {expression in
                        ExpressionFeedItem(expression: expression)
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .id(expression.id)
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    proxy.scrollTo(initialPosition, anchor: .center)
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        var expressions: [Expression] = [
            Expression(
                drawing: UIImage(systemName: "flame")?.pngData() ?? Data(),
                emotion: Emotion.happy,
                title: "Flame",
                caption: "What a hot day outside!",
                date: Date(),
                favorite: false
            ),
            Expression(
                drawing: UIImage(systemName: "house")?.pngData() ?? Data(),
                emotion: Emotion.sad,
                title: "Home",
                caption: "the price of the house is too expensive",
                date: Date(),
                favorite: true
            )
        ]
        
        var body: some View {
            ExpressionFeed(expressions: expressions, initialPosition: expressions[1].id)
        }
    }
    return Preview()
}
