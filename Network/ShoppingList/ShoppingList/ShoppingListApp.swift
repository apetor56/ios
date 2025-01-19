//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by user252223 on 1/5/25.
//

import SwiftUI

@main
struct ShoppingListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
