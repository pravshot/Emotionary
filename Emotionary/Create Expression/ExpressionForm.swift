//
//  ExpressionForm.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/13/24.
//

import SwiftUI

struct ExpressionForm: View {
    @Binding var path: [NavPath]
    @Bindable var expression: Expression
    var isTodaysExpression: Bool
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Image(uiImage: expression.getUIImage())
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(.gray.opacity(0.1), lineWidth: 1)
                            .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 1)
                    )
                Spacer()
            }
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text(isTodaysExpression ? "Today's expression makes me feel..." : "This expression makes me feel...")
                        .font(.title3)
                    
                    HStack(spacing: 20) {
                        ForEach(Emotion.allCases) { emotion in
                            Button {
                                expression.emotion = emotion
                            } label: {
                                Image(expression.emotion == emotion ? emotion.icon : emotion.grayed_icon)
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .id(expression.emotion == emotion)
                                    .transition(.opacity.animation(.default))
                            }
                        }
                    }
                    
                    TextField("Add Title", text: $expression.title)
                        .font(.title3)
                        .bold()
                    TextField("Add Description", text: $expression.caption, axis: .vertical)
                        .font(.callout)
                        .foregroundStyle(.gray)
                        .lineLimit(2, reservesSpace: false)
                        .padding(.bottom)
                }
                .frame(maxWidth: 315)
                Spacer()
            }
            
            
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
        var expression = Expression(drawing: UIImage(systemName: "flame")?.pngData() ?? Data())
        var body: some View {
            ExpressionForm(path: $path, expression: expression, isTodaysExpression: true)
        }
    }
    return Preview()
}
