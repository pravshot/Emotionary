//
//  GalleryView.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/11/24.
//

import SwiftUI
import SwiftData

struct GalleryView: View {
    @Query(sort: \Expression.date, order: .reverse) private var expressions: [Expression]
    @State var selectedViewOption: GalleryViewOption = .Recents
    @State var selectedEmotion: Emotion = .neutral
    @Environment(\.colorScheme) var colorScheme
    let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
//                    TabTitle(text: "Your expressions")
                    
                    Picker("Gallery Options", selection: $selectedViewOption) {
                        Image(systemName: selectedViewOption == .Recents ? "clock.fill" : "clock")
                            .tag(GalleryViewOption.Recents)
                        Image(systemName: ((selectedViewOption == .Emotions && colorScheme == .light) || (selectedViewOption != .Emotions && colorScheme == .dark)) ? "face.smiling.inverse" : "face.smiling")
                            .tag(GalleryViewOption.Emotions)
                        Image(systemName: selectedViewOption == .Favorites ? "star.fill" : "star")
                            .tag(GalleryViewOption.Favorites)
                    }
                    .pickerStyle(.segmented)
                    
                    if selectedViewOption == .Emotions {
                        // select emotion UI here
                        HStack {
                            ForEach(Emotion.allCases) { emotion in
                                Button {
                                    withAnimation(.default) {
                                        selectedEmotion = emotion
                                    }
                                } label: {
                                    ZStack {
                                        Image(emotion.grayed_icon)
                                            .resizable()
                                            .frame(width: selectedEmotion == emotion ? 55 : 45,
                                                    height: selectedEmotion == emotion ? 55 : 45)
                                        Image(emotion.icon)
                                            .resizable()
                                            .frame(width: selectedEmotion == emotion ? 55 : 45,
                                                    height: selectedEmotion == emotion ? 55 : 45)
                                            .opacity(selectedEmotion == emotion ? 1 : 0)
                                    }
                                }
                                if emotion.rawValue < 5 {
                                    Spacer() // put spacers in between emotions
                                }
                            }
                        }
                        .padding(.vertical, 2)
                        .frame(maxWidth: 550)
                    }
                }
                .padding(.horizontal)
                
                let filteredExpressions = filter(
                    expressions: expressions,
                    view: selectedViewOption,
                    emotion: selectedEmotion
                )
                if !filteredExpressions.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
                            ForEach(filteredExpressions) { expression in
                                NavigationLink {
                                    ExpressionFeed(expressions: filteredExpressions, initialPosition: expression.id)
                                        .toolbar(.hidden, for: .tabBar)
                                        .navigationBarTitleDisplayMode(.inline)
                                        .navigationTitle(selectedViewOption.rawValue)
                                } label: {
                                    ExpressionGridItem(expression: expression)
                                }
                            }
                        }
                        .padding(.bottom)
                        .padding(.top, 8)
                        .padding(.horizontal)
                    }
                }
                else {
                    Spacer()
                    noResultsDisplay(viewOption: selectedViewOption, emotion: selectedEmotion)
                    Spacer()
                }
                
            }
            .navigationTitle(Text("Expression Gallery"))
            .navigationBarTitleDisplayMode(.large)
            
        }
        
    }
}

func filter(expressions: [Expression], view: GalleryViewOption, emotion: Emotion) -> [Expression] {
    switch view {
    case .Recents:
        return expressions
    case .Emotions:
        return expressions.filter({ $0.emotion == emotion })
    case .Favorites:
        return expressions.filter({ $0.favorite })
    }
}

struct noResultsDisplay: View {
    var viewOption: GalleryViewOption
    var emotion: Emotion
    
    var noResultsText: String {
        switch viewOption {
        case .Recents:
            "Create expressions to see them here."
        case .Emotions:
            "No expressions tagged with this emotion."
        case .Favorites:
            "Star an expression to add to your favorites."
        }
    }
    let imageWidth = 75.0
    let imageHeight = 75.0
    
    var body: some View {
        switch viewOption {
        case .Recents:
            Image("app-icon-image")
                .resizable()
                .frame(maxWidth: imageWidth, maxHeight: imageHeight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        case .Emotions:
            Image(emotion.icon)
                .resizable()
                .frame(maxWidth: imageWidth, maxHeight: imageHeight)
        case .Favorites:
            Image(systemName: "star.fill")
                .resizable()
                .frame(maxWidth: imageWidth, maxHeight: imageHeight)
                .foregroundStyle(.accent)
        }
        Text(noResultsText)
            .font(.callout)
            .foregroundStyle(.gray)
    }
}

enum GalleryViewOption: String {
    case Recents = "Recents"
    case Emotions = "Emotions"
    case Favorites = "Favorites"
}

#Preview {
    GalleryView()
}
