//
//  CoreDataManager.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 13/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()
    private init() {}

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: PersistentContainer.name)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    var viewContext: NSManagedObjectContext {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        //context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }

    // MARK: - Core Data Saving support
    func saveContext (context: NSManagedObjectContext = CoreDataManager.shared.viewContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
