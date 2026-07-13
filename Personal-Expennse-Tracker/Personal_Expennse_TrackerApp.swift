//
//  Personal_Expennse_TrackerApp.swift
//  Personal-Expennse-Tracker
//
//  Created by Felix B Susanto on 13/7/2026.
//

import SwiftUI
import CoreData

@main
struct Personal_Expennse_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
