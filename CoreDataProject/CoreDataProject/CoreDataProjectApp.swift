//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Bengi Anıl on 24.10.2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {       
    @StateObject var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
