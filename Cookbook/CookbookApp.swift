//
//  CookbookApp.swift
//  Cookbook
//
//  Created by Nadya Simakovich on 01/06/2023.
//

import SwiftUI

@main
struct CookbookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
