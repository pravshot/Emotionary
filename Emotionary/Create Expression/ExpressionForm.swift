//
//  ExpressionForm.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/13/24.
//

import SwiftUI

struct ExpressionForm: View {
    @Binding var path: [NavPath]
    @Binding var expression: Expression
    var isTodaysExpression: Bool
    @Environment(\.modelContext) private var modelContext
//    @State var selectedEmotion: Emotion? = nil
//    @State var title: String = ""
//    @State var description: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            GroupBox {
                Image(uiImage: expression.getUIImage())
                    .resizable()
                    .scaledToFit()
//                    .frame(width: 200, height: 200)
            }
            
            Text(isTodaysExpression ?
                 "Today's expression makes me feel..."
                 : "This expression makes me feel..."
            )
                .font(.headline)
                .fontWeight(.bold)
            
            HStack(spacing: 15) {
                ForEach(Emotion.allCases) { emotion in
                    Button {
                        expression.emotion = emotion
                    } label: {
                        Image(expression.emotion == emotion ? emotion.icon : emotion.grayed_icon)
                            .resizable()
                            .frame(width: 45, height: 45)
                    }
                }
            }
            
            TextField("Add Title", text: $expression.title)
            TextField("Add Description", text: $expression.caption)
                .font(.caption)
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                ShareLink(
                    item: Image(uiImage: UIImage(data: expression.drawing) ?? UIImage()),
                    preview: SharePreview(
                        expression.title.isEmpty ? expression.prompt : expression.title,
                        image: Image(uiImage: UIImage(data: expression.drawing) ?? UIImage())
                    )
                )
                Button("Done") {
                    // save expression
                    modelContext.insert(expression)
                    // return back to home view
                    path.removeAll()
                }
                .disabled((expression.emotion == nil) || expression.title.isEmpty)
            }
        }
        .navigationTitle("New Expression")
    }
}

#Preview {
    struct Preview: View {
        @State var path: [NavPath] = []
        @State var expression = Expression()
        var body: some View {
            ExpressionForm(path: $path, expression: $expression, isTodaysExpression: true)
        }
    }
    return Preview()
}
