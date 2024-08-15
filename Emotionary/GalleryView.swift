//
//  GalleryView.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI

struct GalleryView: View {
    var body: some View {
        VStack {
            Text("Your expressions")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
        }
        .padding(.horizontal)
    }
}

#Preview {
    GalleryView()
}
