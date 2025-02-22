//
//  ExpressionForm.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/13/24.
//

import SwiftUI

struct ExpressionForm: View {
    @Binding var expression: Expression
    @Binding var path: [String]
    var returnToHome: () -> Void
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            if UIDevice.isIPhone {
                VStack {
                    ExpressionImageView(expression: $expression)
                    FormView(expression: $expression, lineSpace: 4)
                    Spacer()
                }
            } else {
                HStack {
                    ExpressionImageView(expression: $expression)
                    FormView(expression: $expression, lineSpace: 8)
                        .padding(.leading)
                }
                .padding(.vertical)
            }
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
                    item: Image(uiImage: expression.getUIImageWithBackground(colorScheme == .light ? .white : .black)),
                    subject: Text(expression.prompt),
                    message: Text(expression.caption),
                    preview: SharePreview(
                        "My Expression",
                        image: Image(uiImage: expression.getUIImageWithBackground(colorScheme == .light ? .white : .black))
                    )
                )
                Button("Done") {
                    // lower keyboard if raised
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    expression.date = Date()
                    modelContext.insert(expression) // save expression
                    returnToHome()
                }
                .disabled(expression.emotion == nil)
            }
        }
        .navigationTitle("New Expression")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        
        
    }
}

struct iPhoneExpressionFormView: View {
    var body: some View {
        Text("Hello, world!")
    }
}


struct ExpressionImageView : View {
    @Binding var expression: Expression
    var body: some View {
        Image(uiImage: expression.getUIImage())
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 1)
            )
    }
}

struct FormView: View {
    @Binding var expression: Expression
    var lineSpace: Int
    @FocusState private var isDescFocused: Bool
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tag an emotion!")
                .font(.title2)
                .fontWeight(.semibold)
            
            HStack {
                ForEach(Emotion.allCases) { emotion in
                    Button {
                        expression.emotion = emotion
                    } label: {
                        ZStack {
                            Image(emotion.grayed_icon)
                                .resizable()
                                .frame(width: 50, height: 50)
                            Image(emotion.icon)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .opacity(expression.emotion == emotion ? 1 : 0)
                                .animation(.default, value: expression.emotion == emotion)
                        }
                    }
                    if emotion.rawValue < 5 {
                        Spacer()
                    }
                }
            }
            
            Divider()
                .padding(.top, 8)
                .padding(.bottom, 4)
            
            TextField("Jot down a few thoughts...", text: $expression.caption, axis: .vertical)
                .font(.body)
                .lineLimit(lineSpace, reservesSpace: true)
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
        .frame(maxWidth: 400)
    }
}

#Preview {
    struct Preview: View {
        @State var expression = Expression(drawing: UIImage(systemName: "flame")?.pngData() ?? Data())
        @State var path: [String] = []
        var body: some View {
            ExpressionForm(expression: $expression, path: $path, returnToHome: {})
        }
    }
    return Preview()
}
