//
//  DrawExpression.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI
import PencilKit

struct DrawExpression: View {
    @Binding var expression: Expression
    @Binding var path: [String]
    var returnToHome: () -> Void
    
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
    let activeHeight = 52.5
    let inactiveHeight = 37.5
    let inactiveColor = Color.gray
    let eraserColor = Color(red: 1.0, green: 0.59, blue: 0.57)
    let selectionAnimation: Animation = .snappy
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
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
                .padding(.bottom, 3)
                .frame(height: nil)
            }
            // drawing toolbar overlay
            VStack {
                Spacer()
                HStack(spacing: 20) {
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
                        .labelsHidden()
                    
                }
                .fixedSize()
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .overlay(
                            Capsule()
                                .stroke(.gray.opacity(0.1), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 1)
                )
                .padding(.bottom, 24)
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .toolbar {
            // Go back to Home
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    returnToHome()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Next") {
                    expression.drawing = getUIImageFromCanvas(canvas).heicData() ?? Data()
                    path.append("Form")
                }
                .disabled(isCanvasEmpty(canvas))
            }
        }
        .navigationTitle("New Expression")
        .navigationBarTitleDisplayMode(.inline)
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
    @Environment(\.colorScheme) var colorScheme
    
    let onChange: () -> Void
    
    let penStrokeWidth = 2.875
    let paintbrushStrokeWidth = 22.5
    var ink: PKInkingTool {
        let color = drawingTool == .pen ? UIColor(penColor) : UIColor(paintbrushColor)
        let adjustedColor: UIColor = colorScheme == .dark ? PKInkingTool.convertColor(color, from: .light, to: .dark) : color
        let width = drawingTool == .pen ? penStrokeWidth : paintbrushStrokeWidth
        return PKInkingTool(drawingTool == .pen ? .monoline : drawingTool , color: adjustedColor, width: width)
    }
    
    let eraserWidth = 38.75
    var eraser: PKEraserTool {
        return PKEraserTool(.bitmap, width: eraserWidth)
    }
    
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
        @State var expression = Expression()
        @State var path: [String] = []
        var body: some View {
            DrawExpression(expression: $expression, path: $path, returnToHome: {})
        }
    }
    return Preview()
}
