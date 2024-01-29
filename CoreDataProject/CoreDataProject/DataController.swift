//
//  DataController.swift
//  CoreDataProject
//
//  Created by Bengi Anıl on 24.10.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
        
//      Aynı datayı bir kere yazmamıza olanak sağlar, defalarca göstermeyi engeller
//      Mesela country'nin unique olması gerekiyor bu kod sayesinde öyle de gösteriliyor
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
