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
                            // need to implement deletion logic
                            // modelContext.delete(expression)
                        }
                    } message: {
                        Text("You cannot undo this action")
                    }
                }
                GroupBox {
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
                }
                HStack(alignment: .top, spacing: 10) {
                    Text(expression.title)
                        .font(.title2)
                        .bold()
                    Spacer()
                    ShareLink(
                        item: Image(uiImage: expression.getUIImage()),
                        subject: Text(expression.title),
                        message: Text(expression.caption),
                        preview: SharePreview(
                            expression.title,
                            image: Image(uiImage: expression.getUIImage())
                        )
                    ) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 25)
                    }
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
                    Image(expression.emotion!.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 26)
                }
                if !expression.caption.isEmpty {
                    Text(expression.caption)
                        .font(.callout)
                }
                Text(formatDate(expression.date))
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: 600, maxHeight: getMaxPostHeight())
            
        }
    }
}

func formatDate(_ date: Date) -> String {
    let calendar = Calendar.current
    // if year old
    if date < calendar.date(byAdding: .year, value: -1, to: Date()) ?? Date.distantPast {
        return date.formatted(date: .long, time: .omitted)
    } 
    // if week old
    else if date < calendar.date(byAdding: .weekOfYear, value: -1, to: Date()) ?? Date.distantPast {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: date)
    }
    // recent
    else {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

func getMaxPostHeight() -> CGFloat? {
    let ui = UIScreen.current
    let maxScale = 0.75
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
            title: "Flame",
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
