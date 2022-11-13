//
//  weatherAppDmApp.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI


@main

struct weatherAppDmApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
