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

    @State var tab: Tab = .home

    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $tab) {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(Tab.home)
                    GalleryView()
                        .tabItem {
                            Image(systemName: "photo.on.rectangle")
                            Text("Gallery")
                        }
                        .tag(Tab.gallery)
                }
            }
        }
    }

}

enum Tab {
    case home
    case gallery
}

#Preview {
    ContentView()
        .modelContainer(for: Expression.self, inMemory: true)
}
