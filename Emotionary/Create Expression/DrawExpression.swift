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
    var isTodaysExpression: Bool
    @State var refreshView = false
    
    @State var canvas = PKCanvasView()
    @State var color: Color = .accentColor
    @State var drawingTool: PKInkingTool.InkType = .pen
    @State var isDrawing = true
    @Environment(\.undoManager) var undoManager

    var body: some View {
        VStack {
            ExpressionPrompt(prompt: $prompt)
                .padding()
                .id(refreshView)
            CanvasView(canvas: $canvas, 
                       color: $color,
                       drawingTool: $drawingTool,
                       isDrawing: $isDrawing,
                       onChange: {refreshView.toggle()}
            )
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Spacer()
                        Button {
                            undoManager?.undo()
                        } label: {
                            Image(systemName: "arrow.uturn.backward")
                        }
                        .disabled((undoManager != nil) && !undoManager!.canUndo)
                        Button {
                            undoManager?.redo()
                        } label: {
                            Image(systemName: "arrow.uturn.forward")
                        }
                        .disabled((undoManager != nil) && !undoManager!.canRedo)
                        Button {
                            drawingTool = .pen
                            isDrawing = true
                        } label: {
                            Image(systemName: (drawingTool == .pen && isDrawing)  ? "pencil.line" : "pencil")
                        }
                        Button {
                            drawingTool = .marker
                            isDrawing = true
                        } label: {
                            Image(systemName: (drawingTool == .marker && isDrawing) ? "paintbrush.pointed.fill" : "paintbrush.pointed")
                        }
                        Button {
                            isDrawing = false
                        } label: {
                            Image(systemName: isDrawing ? "eraser" : "eraser.fill")
                        }
                        ColorPicker("", selection: $color)
                    }
                }
                .frame(height: nil)
        }
        .toolbar {
            ToolbarItemGroup {
                NavigationLink("Next") {
                    ExpressionForm(drawing: getUIImage(canvas), prompt: prompt, isTodaysExpression: isTodaysExpression)
                }
                .disabled(isCanvasEmpty(canvas))
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

struct CanvasView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var color: Color
    @Binding var drawingTool: PKInkingTool.InkType
    @Binding var isDrawing: Bool
    
    let onChange: () -> Void
    
    var ink: PKInkingTool {
        PKInkingTool(drawingTool, color: UIColor(color))
    }
    
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDrawing ? ink : eraser
        canvas.minimumZoomScale = 1.0
        canvas.maximumZoomScale = 2.5
        
        let toolPicker = PKToolPicker.init()
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.becomeFirstResponder()
        
        canvas.delegate = context.coordinator

        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = isDrawing ? ink : eraser
    }
    
    func makeCoordinator() -> Coordinator {
      Coordinator(canvasView: $canvas, onChange: onChange)
    }
}

class Coordinator: NSObject, PKCanvasViewDelegate {
    var canvasView: Binding<PKCanvasView>
    let onChange: () -> Void

    init(canvasView: Binding<PKCanvasView>, onChange: @escaping () -> Void) {
        self.canvasView = canvasView
        self.onChange = onChange
    }

    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        onChange()
    }
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
