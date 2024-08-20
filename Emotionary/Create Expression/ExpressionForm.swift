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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            GroupBox {
                Image(uiImage: expression.getUIImage())
                    .resizable()
                    .scaledToFit()
            }
            
            Text("This expression makes me feel...")
                .font(.title3)
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
                .font(.title)
            TextField("Add Description", text: $expression.caption)
                .font(.callout)
            Spacer()
        }
        .padding(.horizontal)
        .toolbar {
            // Go back to DrawingView
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Edit")
                    }
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                ShareLink(
                    item: Image(uiImage: expression.getUIImage()),
                    preview: SharePreview(
                        expression.title.isEmpty ? expression.prompt : expression.title,
                        image: Image(uiImage: expression.getUIImage())
                    )
                )
                Button("Done") {
                    modelContext.insert(expression) // save expression
                    path.removeAll() // return back to home view
                }
                .disabled((expression.emotion == nil) || expression.title.isEmpty)
            }
        }
        .navigationTitle(isTodaysExpression ? "Today's Expression" : "New Expression")
        .navigationBarBackButtonHidden()
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
