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
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @FocusState private var isDescFocused: Bool
    
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
                if UIDevice.isIPad { Spacer() }
                VStack(alignment: .leading) {
                    Text("This expression makes me feel...")
                        .font(.title2)
                    
                    HStack(spacing: 20) {
                        ForEach(Emotion.allCases) { emotion in
                            Button {
                                expression.emotion = emotion
                            } label: {
                                ZStack {
                                    Image(emotion.grayed_icon)
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                    Image(emotion.icon)
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        .opacity(expression.emotion == emotion ? 1 : 0)
                                        .animation(.default, value: expression.emotion == emotion)
                                }
                            }
                        }
                    }
                    
                    TextField("Add Title", text: $expression.title)
                        .font(.title3)
                        .bold()
                        .submitLabel(.done)
                    TextField("Add Description", text: $expression.caption, axis: .vertical)
                        .font(.callout)
                        .foregroundStyle(.gray)
                        .lineLimit(2, reservesSpace: false)
                        .submitLabel(.done)
                        .focused($isDescFocused)
                        .onChange(of: expression.caption) {_, newValue in
                            if newValue.last == "\n" {
                                expression.caption.removeLast()
                                isDescFocused = false
                            }
                        }
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
                    expression = Expression() // reset expression
                    path.removeAll() // return back to home view
                }
                .disabled((expression.emotion == nil) || expression.title.isEmpty)
            }
        }
        .navigationTitle("New Expression")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    struct Preview: View {
        @State var path: [NavPath] = []
        @State var expression = Expression(drawing: UIImage(systemName: "flame")?.pngData() ?? Data())
        var body: some View {
            ExpressionForm(path: $path, expression: $expression)
        }
    }
    return Preview()
}
