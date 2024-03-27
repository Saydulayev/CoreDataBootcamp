//
//  CoreDataBootcampApp.swift
//  CoreDataBootcamp
//
//  Created by Akhmed on 27.03.24.
//

import SwiftUI

@main
struct CoreDataBootcampApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
