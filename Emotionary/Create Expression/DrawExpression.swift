//
//  DrawExpression.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI
import PencilKit

struct DrawExpression: View {
    @State var prompt: String
    @State var canvas = PKCanvasView()
    var isTodaysExpression: Bool
    @State var showOverlay = false
    @State var refreshView = false

    var body: some View {
        VStack {
            ExpressionPrompt(prompt: $prompt)
                .padding()
                .id(refreshView)
            DrawingCanvas(canvas: $canvas)
        }
        .overlay {
            if showOverlay {
                Image(uiImage: canvas.drawing.image(from: canvas.drawing.bounds, scale: 1.0))
                    .resizable()
                    .scaledToFit()
                    .border(.black)
            }
        }
        .toolbar {
            ToolbarItemGroup {
                NavigationLink("Next") {
                    ExpressionForm(drawing: getUIImage(canvas), prompt: prompt, isTodaysExpression: isTodaysExpression)
                }
                .disabled(isCanvasEmpty(canvas))
                Button("overlay") {
                    showOverlay.toggle()
                }
            }
        }
        .navigationTitle("New Expression")
    }
}

func getUIImage(_ canvas: PKCanvasView) -> UIImage {
    return canvas.drawing.image(from: canvas.drawing.bounds, scale: UIScreen.current?.scale ?? 1)
}
func isCanvasEmpty(_ canvas: PKCanvasView) -> Bool {
    return canvas.drawing.bounds.isEmpty
}

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}

#Preview {
    DrawExpression(prompt: Prompt.random(), isTodaysExpression: true)
}
