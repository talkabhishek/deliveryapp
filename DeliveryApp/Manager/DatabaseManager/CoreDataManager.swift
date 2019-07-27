//
//  CoreDataManager.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 13/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func clearData()
    func getDeliveryCount() -> Int
    func saveInCoreData(array: [DeliveryItem])
    func getDeliveryList(offset: Int, limit: Int) -> [DeliveryItem]
}

class CoreDataManager: CoreDataManagerProtocol {
    lazy var stack: CoreDataStack = CoreDataStack.shared
    // MARK: - Clear Data for Entity
    func clearData() {
        let context = stack.savingContext
        let entityName: String = String(describing: DeliveryItem.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let objects  = try? context.fetch(fetchRequest) as? [NSManagedObject]
        _ = objects.map { $0.map { context.delete($0) } }
        stack.saveContext(context: context)
        //let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        //_ = try? stack.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
    }

    // Get Delivery Count
    func getDeliveryCount() -> Int {
        let context = stack.managedContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDesc = NSEntityDescription.entity(forEntityName: String(describing: DeliveryItem.self), in:
            context)
        fetchRequest.entity = entityDesc
        let count = try? context.count(for: fetchRequest)
        return count ?? 0
    }

    // MARK: - Save list to Core Data
    func saveInCoreData(array: [DeliveryItem]) {
        DispatchQueue.global().async {
            self.stack.saveContext(context: self.stack.managedContext)
        }
    }

    func getDeliveryList(offset: Int, limit: Int) -> [DeliveryItem] {
        let context = stack.managedContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = limit
        let entityDesc = NSEntityDescription.entity(forEntityName: String(describing: DeliveryItem.self), in: context)
        fetchRequest.entity = entityDesc
        var fetchedOjects = try? context.fetch(fetchRequest)
            as? [DeliveryItem]
        fetchedOjects?.sort { (item1, item2) -> Bool in
            return item1.id < item2.id
        }
        return fetchedOjects ?? []
    }

}
