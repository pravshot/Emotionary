//
//  test.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/14/24.
//

import SwiftUI
import PencilKit

struct test: View {
    var drawing: PKDrawing
    
    var body: some View {
        VStack {
            Image(uiImage: drawing.image(from: drawing.bounds, scale: 1.0))
                .resizable()
                .scaledToFit()
                .border(.black)
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                ShareLink(item: Image(uiImage: drawing.image(from: drawing.bounds, scale: 1.0)),
                          preview: SharePreview("drawing", image: Image(uiImage: drawing.image(from: drawing.bounds, scale: 1.0)) ))
                Button("Done") {
                    // save expression
                    // return back to home view
                }
            }
        }
        .navigationTitle("New Expression")
    }
}

#Preview {
    test(drawing: PKDrawing())
}
