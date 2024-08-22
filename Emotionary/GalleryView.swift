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
    var filteredExpressions: [Expression] {
        filter(
            expressions: expressions,
            view: selectedViewOption,
            emotion: selectedEmotion
        )
    }
    @Environment(\.colorScheme) var colorScheme
    let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
    
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
                        ScrollViewReader { proxy in
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 0) {
                                    ForEach(Emotion.allCases) { emotion in
                                        Image(selectedEmotion == emotion ? emotion.icon : emotion.grayed_icon)
                                            .resizable()
                                            .frame(width: selectedEmotion == emotion ? 55: 45,
                                                   height: selectedEmotion == emotion ? 55: 45)
                                            .gesture(TapGesture().onEnded({
                                                withAnimation(.smooth(duration: 0.2)) {
                                                    proxy.scrollTo(emotion.rawValue, anchor: .center)
                                                    selectedEmotion = emotion
                                                }
                                            }))
                                            .id(emotion.rawValue)
                                            .padding(.horizontal)
                                            .padding(.vertical, 2)
                                    }
                                }
                            }
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                    withAnimation(.spring(duration: 0.5)) {
                                        proxy.scrollTo(selectedEmotion, anchor: .center)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
                        ForEach(filteredExpressions)
                        { expression in
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
