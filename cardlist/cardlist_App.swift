//
//  Card_List_2App.swift
//  Card List 2
//
//  Created by Bryce Eppler on 2022-05-05.
//

import SwiftUI

@main
struct cardlist_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataStore())
        }
    }
}
