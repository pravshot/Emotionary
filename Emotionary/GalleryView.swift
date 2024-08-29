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
    
    var noResultsText: String {
        switch selectedViewOption {
        case .Recents:
            "Create expressions to see them here."
        case .Emotions:
            "No expressions tagged with this emotion."
        case .Favorites:
            "Star an expression to add to your favorites."
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("Your expressions")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    
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
                                    selectedEmotion = emotion
                                } label: {
                                    Image(selectedEmotion == emotion ? emotion.icon : emotion.grayed_icon)
                                        .resizable()
                                        .frame(width: selectedEmotion == emotion ? 55: 45,
                                               height: selectedEmotion == emotion ? 55: 45)
                                        .animation(.snappy, value: selectedEmotion)
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
                    Text(noResultsText)
                        .font(.callout)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                
            }
            
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

enum GalleryViewOption {
    case Recents
    case Emotions
    case Favorites
}

#Preview {
    GalleryView()
}
