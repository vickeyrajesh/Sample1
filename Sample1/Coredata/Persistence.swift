//
//  Persistence.swift
//  Sample1
//
//  Created by Rajesh Yadav on 04/08/25.
//

import CoreData

final class PersistenceController {
    static let shared = PersistenceController()
    private let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Sample1")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        context = container.viewContext
    }
}
