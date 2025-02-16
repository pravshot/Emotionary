//
//  ContentView.swift
//  Emotionary
//
//  Created by Praveen Kalva on 8/10/24.
//

import SwiftUI
import SwiftData
import UserNotifications

struct ContentView: View {
    @State var showExpressionCreator = false
    @State var newExpression = Expression()
    @State var tab: Tab = .create

    var body: some View {
        ZStack {
            TabView(selection: $tab) {
                TrendsView()
                    .tabItem {
                        Label("Trends", systemImage: "chart.bar")
                            .environment(\.symbolVariants, tab == .trends ? .fill : .none)
                    }
                    .tag(Tab.trends)
                CreateView(showExpressionCreator: $showExpressionCreator, newExpression: $newExpression)
                    .tabItem {
                        Label("Create", systemImage: "plus.circle")
                            .environment(\.symbolVariants, tab == .create ? .fill : .none)
                    }
                    .tag(Tab.create)
                GalleryView()
                    .tabItem {
                        Label("Gallery", systemImage: "photo.on.rectangle.angled")
                            .environment(\.symbolVariants, tab == .gallery ? .fill : .none)
                    }
                    .tag(Tab.gallery)
            }
            .onAppear {
                requestNotificationPermission()
                setupNotification()
            }
            
            // Expression Creator overlay
            if showExpressionCreator {
                ExpressionCreator(isPresented: $showExpressionCreator, expression: $newExpression)
                    .id(newExpression.id)
                    .ignoresSafeArea()
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            }
        }
        .animation(.snappy, value: showExpressionCreator)
    }
}

func requestNotificationPermission() {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
            print("Permission granted")
        } else {
            print("Permission denied")
        }
    }
}

func setupNotification() {
    cancelDailyNotification()
    scheduleDailyNotification()
}

func scheduleDailyNotification() {
    // Notification Content
    let content = UNMutableNotificationContent()
    content.title = "Expressly"
    content.body = notificationMessages.randomElement()!
    content.sound = UNNotificationSound.default
    // Notification Timing
    let dateComponents = DateComponents(hour: 20, minute: 0) // 8 pm daily
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let request = UNNotificationRequest(identifier: "DailyReminder", content: content, trigger: trigger)
    // Send Notification
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error scheduling notification: \(error)")
        }
    }
}

func cancelDailyNotification() {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["DailyReminder"])
}

private let notificationMessages =
[
    "Take some time to reflect and make an expression.",
    "Sketch your thoughts and reflect on your day.",
    "Unwind with a daily drawing session.",
    "Take a few moments to express yourself.",
    "Capture your thoughts with a quick drawing."
]

enum Tab {
    case create
    case gallery
    case trends
}

#Preview {
    ContentView()
        .modelContainer(for: Expression.self, inMemory: true)
}
