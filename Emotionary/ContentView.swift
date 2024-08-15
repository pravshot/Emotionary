//
//  ContentView.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Expression.date) private var expressions: [Expression]

    @State var activeScreen: Screen = .home
    
    var emotions: [Emotion] = [.upset, .content, .neutral, .happy, .sad]
    
    var body: some View {
        NavigationStack {
            VStack {
                if activeScreen == .home {
                    HomeView()
                } else {
                    GalleryView()
                }
                Spacer()
                MenuBar(activeScreen: $activeScreen)
            }
        }
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
}

enum Screen {
    case home
    case gallery
}

#Preview {
    ContentView()
        .modelContainer(for: Expression.self, inMemory: true)
}
