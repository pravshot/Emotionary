//
//  ExpressionForm.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/13/24.
//

import SwiftUI

struct ExpressionForm: View {
    @Environment(\.modelContext) private var modelContext
    var drawing: UIImage
    var prompt: String
    var isTodaysExpression: Bool
    @State var selectedEmotion: Emotion? = nil
    @State var title: String = ""
    @State var description: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            GroupBox {
                Image(uiImage: drawing)
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
                        selectedEmotion = emotion
                    } label: {
                        Image(selectedEmotion == emotion ? emotion.icon : emotion.grayed_icon)
                            .resizable()
                            .frame(width: 45, height: 45)
                    }
                }
            }
            
            TextField("Add Title", text: $title)
            TextField("Add Description", text: $description)
                .font(.caption)
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                ShareLink(item: Image(uiImage: drawing),
                          preview: SharePreview(title.isEmpty ? prompt : title, image: Image(uiImage: drawing) ))
                Button("Done") {
                    // save expression
                    let newExpression = Expression(
                        drawing: drawing.pngData() ?? Data(),
                        emotion: selectedEmotion!,
                        prompt: prompt,
                        title: title,
                        caption: description
                    )
                    modelContext.insert(newExpression)
                    // return back to home view
                }
                .disabled((selectedEmotion == nil) || title.isEmpty)
            }
        }
        .navigationTitle("New Expression")
    }
}

#Preview {
    ExpressionForm(drawing: UIImage(systemName: "flame")!, prompt: Prompt.random(), isTodaysExpression: false)
}
