//
//  DrawExpression.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI
import PencilKit

struct DrawExpression: View {
    @Binding var path: [NavPath]
    var expression: Expression
    
    @State var refreshView = false
    @State var canvas = PKCanvasView()
    @State var penColor: Color = .accent
    @State var paintbrushColor: Color = .accent
    @State var drawingTool: PKInkingTool.InkType = .pen
    @State var isDrawing = true
    @Environment(\.undoManager) var undoManager
    
    var isPenSelected: Bool { drawingTool == .pen && isDrawing }
    var isPaintbrushSelected: Bool { drawingTool == .marker && isDrawing }
    var isEraserSelected: Bool { !isDrawing }
    @State var toolChanged = false
    let activeHeight = 45.0
    let inactiveHeight = 30.0
    let inactiveColor = Color.gray
    let eraserColor = Color(red: 1.0, green: 0.59, blue: 0.57)
    let selectionAnimation: Animation = .snappy
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            ExpressionPrompt(prompt: expression.prompt)
                .padding(.horizontal)
                .id(refreshView)
            CanvasView(canvas: $canvas, 
                       penColor: $penColor,
                       paintbrushColor: $paintbrushColor,
                       drawingTool: $drawingTool,
                       isDrawing: $isDrawing,
                       onChange: { refreshView.toggle() }
            )
            .padding(.bottom, 10)
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Spacer()
                        HStack(spacing: 10) {
                            // Undo Button
                            Button {
                                undoManager?.undo()
                            } label: {
                                Image(systemName: "arrow.uturn.backward")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                            }
                            .disabled((undoManager != nil) && !undoManager!.canUndo)
                            // Redo Button
                            Button {
                                undoManager?.redo()
                            } label: {
                                Image(systemName: "arrow.uturn.forward")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                            }
                            .disabled((undoManager != nil) && !undoManager!.canRedo)
                            // Pen
                            Button {
                                drawingTool = .pen
                                isDrawing = true
                                toolChanged.toggle()
                            } label: {
                                Image("pen-icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: isPenSelected ? activeHeight : inactiveHeight)
                                    .foregroundStyle(isPenSelected ? penColor : inactiveColor)
                                    .animation(selectionAnimation, value: isPenSelected)
                            }
                            // Paintbrush
                            Button {
                                drawingTool = .marker
                                isDrawing = true
                                toolChanged.toggle()
                            } label: {
                                Image("paintbrush-icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: isPaintbrushSelected ? activeHeight : inactiveHeight)
                                    .foregroundStyle(isPaintbrushSelected ? paintbrushColor : inactiveColor)
                                    .animation(selectionAnimation, value: toolChanged)
                            }
                            // Eraser
                            Button {
                                isDrawing = false
                                toolChanged.toggle()
                            } label: {
                                Image("eraser-icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: isEraserSelected ? activeHeight : inactiveHeight)
                                    .foregroundStyle(isEraserSelected ? eraserColor : inactiveColor)
                                    .animation(selectionAnimation, value: isEraserSelected)
                            }
                            // Color Selection
                            ColorPicker("", selection: drawingTool == .pen ? $penColor : $paintbrushColor)
                                .disabled(!isDrawing)
                            
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .overlay(
                            Capsule()
                                .inset(by: 0.5)
                                .stroke(.gray.opacity(0.1), lineWidth: 1)
                                .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 1)
                        )
                        Spacer()
                    }
                }
                .frame(height: nil)
        }
        .toolbar {
            // Go back to Home
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Home")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Next") {
                    expression.drawing = getUIImageFromCanvas(canvas).pngData() ?? Data()
                    path.append(.ExpressionForm)
                }
                .disabled(isCanvasEmpty(canvas))
            }
        }
        .navigationTitle("New Expression")
        .navigationBarBackButtonHidden()
    }
}

func getUIImageFromCanvas(_ canvas: PKCanvasView) -> UIImage {
    return canvas.drawing.image(from: canvas.bounds.intersection(canvas.drawing.bounds), scale: UIScreen.current?.scale ?? 1)
}
func isCanvasEmpty(_ canvas: PKCanvasView) -> Bool {
    return canvas.drawing.bounds.isEmpty
}

struct CanvasView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var penColor: Color
    @Binding var paintbrushColor: Color
    @Binding var drawingTool: PKInkingTool.InkType
    @Binding var isDrawing: Bool
    
    let onChange: () -> Void
    
    var ink: PKInkingTool {
        PKInkingTool(drawingTool, color: drawingTool == .pen ? UIColor(penColor) : UIColor(paintbrushColor))
    }
    
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDrawing ? ink : eraser
        canvas.minimumZoomScale = 1.0
        canvas.maximumZoomScale = 2.25
        
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
    struct Preview: View {
        @State var path: [NavPath] = []
        var expression = Expression()
        var body: some View {
            DrawExpression(path: $path, expression: expression)
        }
    }
    return Preview()
}