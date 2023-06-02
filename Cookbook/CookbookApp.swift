//
//  CookbookApp.swift
//  Cookbook
//
//  Created by Nadya Simakovich on 01/06/2023.
//

import SwiftUI
import CoreData

@main
struct CookbookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
            WindowGroup {
                NavigationView {
                    UserRegistrationView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
        }
    }
}
