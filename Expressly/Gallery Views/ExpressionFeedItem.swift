//
//  ExpressionFeedItem.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/17/24.
//

import SwiftUI

struct ExpressionFeedItem: View {
    var expression: Expression
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    @State private var isPresentingConfirm: Bool = false
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                GroupBox {
                    HStack {
                        Text(expression.prompt)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Menu {
                            Button(role: .destructive) {
                                isPresentingConfirm = true
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .foregroundStyle(.accent)
                        }
                    }
                    .confirmationDialog("Are you sure you want to delete this expression?", isPresented: $isPresentingConfirm) {
                        Button("Delete Expression", role: .destructive) {
                             modelContext.delete(expression)
                        }
                    } message: {
                        Text("You cannot undo this action")
                    }
                }
                GroupBox {
                    ZStack(alignment: .bottomTrailing) {
                        HStack {
                            Spacer()
                            Image(uiImage: expression.getUIImage())
                                .resizable()
                                .scaledToFit()
                                .onTapGesture(count: 2, perform: {
                                    expression.favorite.toggle()
                                })
                            Spacer()
                        }
                        HStack(spacing: 12) {
                            Button {
                                expression.favorite.toggle()
                            } label: {
                                Image(systemName: expression.favorite ? "star.fill" : "star")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 25)
                                    .id(expression.favorite)
                                    .transition(.scale.animation(.default))
                            }
                            ShareLink(
                                item: Image(uiImage: expression.getUIImageWithBackground(colorScheme == .light ? .white : .black)),
                                subject: Text(expression.prompt),
                                message: Text(expression.caption),
                                preview: SharePreview(
                                    "My Expression",
                                    image: Image(uiImage: expression.getUIImageWithBackground(colorScheme == .light ? .white : .black))
                                )
                            ) {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 25)
                            }
                            Image(expression.emotion!.icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 26)
                        }
                        .fixedSize()
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    Capsule()
                                        .stroke(.gray.opacity(0.1), lineWidth: 1)
                                )
                                .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 1)
                        )
                        .offset(x:10, y:10)
                    }
                }
                .backgroundStyle(colorScheme == .dark ? .black : .white)
                if !expression.caption.isEmpty {
                    Text(expression.caption)
                        .font(.body)
                }
                HStack(alignment: .bottom) {
                    Spacer()
                    Text(formatDate(expression.date))
                        .font(.headline)
                        .foregroundStyle(.gray)
                    Spacer()
                    
                }
                .padding(.top, 8)
            }
            .frame(maxWidth: 600, maxHeight: getMaxPostHeight())
            
        }
    }
}

func formatDate(_ date: Date) -> String {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d"
    let day = dateFormatter.string(from: date)
    let timeOfDay = switch calendar.component(.hour, from: date) {
        case 5..<12:
            "Morning"
        case 12..<17:
            "Afternoon"
        case 17..<21:
            "Evening"
        default:
            "Night"
    }
    return (day + " " + timeOfDay).uppercased()
}

func getMaxPostHeight() -> CGFloat? {
    let ui = UIScreen.current
    let maxScale = 0.70
    if (ui != nil) {
        return ui!.bounds.height * maxScale
    } else {
        return nil
    }
}

#Preview {
    struct Preview: View {
        var expression = Expression(
            drawing: UIImage(systemName: "flame")?.pngData() ?? Data(),
            emotion: Emotion.happy,
            caption: "What a hot day outside!",
            date: Date().addingTimeInterval(-1000000),
            favorite: false
        )
        
        var body: some View {
            ExpressionFeedItem(expression: expression)
        }
    }
    return Preview()
}
