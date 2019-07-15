//
//  CoreDataStack.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 13/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack {

    private let modelName: String
    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var savingContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    //lazy var managedContext: NSManagedObjectContext = persistentContainer.viewContext
    var managedContext: NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        //context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }

    // MARK: - Core Data Saving support
    func saveManagedContext () {
        saveContext(context: managedContext)
    }

    func saveContext (context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func executeRequest(request: NSPersistentStoreRequest,
                        context: NSManagedObjectContext) {
        do {
            try persistentContainer.persistentStoreCoordinator.execute(request, with: context)
        } catch {
            debugPrint("There is an error in deleting records")
        }
    }

}