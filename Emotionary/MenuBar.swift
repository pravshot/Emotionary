//
//  MenuBar.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI

struct MenuBar: View {
    
    @Binding var activeScreen: Screen
    
    var body: some View {
        HStack(alignment: .bottom) {
            Spacer()
            VStack {
                Button {
                    activeScreen = .home
                } label: {
                    Image(systemName: "house.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(activeScreen == .home ? .accent : .gray)
                    
                }
                Text("Home")
                    .font(.system(size:8))
            }
            Spacer()
            VStack {
                Button {
                    activeScreen = .gallery
                } label: {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(activeScreen == .gallery ? .accent : .gray)
                }
                Text("Gallery")
                    .font(.system(size:8))
            }
            Spacer()
        }
        .frame(minHeight: 30, maxHeight: 40)
    }
}

#Preview {
    struct Preview : View {
        @State var activeScreen: Screen = .home
        var body : some View {
            MenuBar(activeScreen: $activeScreen)
        }
    }
    return Preview()
}
