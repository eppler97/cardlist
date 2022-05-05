//
//  Card_List_2App.swift
//  Card List 2
//
//  Created by Bryce Eppler on 2022-05-05.
//

import SwiftUI

@main
struct Card_List_2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
