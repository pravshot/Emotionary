//
//  DrawingCanvas.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI
import PencilKit

struct DrawingCanvas: View {
    @Binding var canvas: PKCanvasView
    @State var color: Color = .accentColor
    @State var drawingTool: PKInkingTool.InkType = .pen
    @State var isDrawing = true
    @Environment(\.undoManager) var undoManager
    
    var body: some View {
        VStack {
            CanvasView(canvas: $canvas, color: $color, drawingTool: $drawingTool, isDrawing: $isDrawing)
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Spacer()
                        Button {
                            undoManager?.undo()
                        } label: {
                            Image(systemName: "arrow.uturn.backward")
                        }
                        Button {
                            undoManager?.redo()
                        } label: {
                            Image(systemName: "arrow.uturn.forward")
                        }
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
        }
        .frame(height: nil)
    }
}

struct CanvasView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var color: Color
    @Binding var drawingTool: PKInkingTool.InkType
    @Binding var isDrawing: Bool
    
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

        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = isDrawing ? ink : eraser
    }
}

#Preview {
    struct PreviewView: View {
        @State var canvas = PKCanvasView()
        var body: some View {
            DrawingCanvas(canvas: $canvas)
        }
    }
    return PreviewView()
}
