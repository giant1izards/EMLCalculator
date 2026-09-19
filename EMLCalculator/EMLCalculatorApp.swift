//
//  EMLCalculatorApp.swift
//  EMLCalculator
//
//  Created by Nathan McCrina on 9/18/26.
//

import SwiftUI
import SwiftData

@main
struct EMLCalculatorApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Account.self, Transaction.self, AppSettings.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State private var settingsContext = SettingsContext()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(settingsContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
