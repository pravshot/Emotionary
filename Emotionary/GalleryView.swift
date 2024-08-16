//
//  GalleryView.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI
import SwiftData

struct GalleryView: View {
    @Query(sort: \Expression.date) private var expressions: [Expression]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Your expressions")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                ForEach(expressions) { expression in
                    VStack {
                        Image(uiImage: expression.getUIImage())
                        Text(expression.title)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    GalleryView()
}
