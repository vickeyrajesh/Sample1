//
//  Sample1App.swift
//  Sample1
//
//  Created by Rajesh Yadav on 04/08/25.
//

import SwiftUI

@main
struct Sample1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
