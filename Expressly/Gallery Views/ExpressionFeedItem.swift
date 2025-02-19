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
                        Image(expression.emotion!.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28)
                            .padding(.trailing, 3)
                        Text(expression.prompt)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                }
                .padding(.horizontal, -4)
                .backgroundStyle(
                    LinearGradient(
                            gradient: Gradient(colors: [expression.emotion!.color.opacity(0.1), expression.emotion!.color.opacity(0.25)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                )
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
                        HStack(spacing: 16) {
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
                        }
                        .fixedSize()
                        .padding(.horizontal, 12)
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
                .padding(.horizontal, -4)
                .backgroundStyle(colorScheme == .dark ? .black : .white)
                if !expression.caption.isEmpty {
                    ScrollView {
                        Text(expression.caption)
                            .font(.body)
                            .lineLimit(nil)
                    }
                    .frame(maxHeight: 80)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 8)
                    Divider()
                }
                HStack(alignment: .bottom) {
                    Text(formatDate(expression.date))
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                    Spacer()
                    Menu {
                        Button(role: .destructive) {
                            isPresentingConfirm = true
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .resizable()
                            .foregroundStyle(.accent)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                    }
                }
                .padding(.top, 4)
                .padding(.horizontal, 8)
                .confirmationDialog("Are you sure you want to delete this expression?", isPresented: $isPresentingConfirm) {
                    Button("Delete Expression", role: .destructive) {
                         modelContext.delete(expression)
                    }
                } message: {
                    Text("You cannot undo this action")
                }
            }
            .frame(maxWidth: 600, maxHeight: getMaxPostHeight())
        }
    }
}

func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d"
    return dateFormatter.string(from: date)
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
