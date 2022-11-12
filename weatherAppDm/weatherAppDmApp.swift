//
//  weatherAppDmApp.swift
//  weatherAppDm
//
//  Created by David on 2022-11-01.
//

import SwiftUI


@main

struct weatherAppDmApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ScreenView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
