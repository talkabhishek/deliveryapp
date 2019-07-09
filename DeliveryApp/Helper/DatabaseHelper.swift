//
//  DatabaseHelper.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 05/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import CoreData

class DatabaseHelper {

    static let shared = DatabaseHelper()
    private init() {}

    // MARK: - Save list to Core Data
    func saveInCoreDataWith(array: [[String: AnyObject]]?) {
        guard let array = array else { return }
        _ = array.map { self.createDeliveryEntityFrom(dictionary: $0) }
        try? CoreDataStack.shared.persistentContainer.viewContext.save()
    }

    private func createDeliveryEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        if let deliveryEntity = NSEntityDescription.insertNewObject(forEntityName:
            String(describing: DeliveryItem.self), into: context) as? DeliveryItem {
            deliveryEntity.id = dictionary[Key.DeliveryItem.id] as? Int32 ?? 0
            deliveryEntity.desc = dictionary[Key.DeliveryItem.description] as? String
            deliveryEntity.imageURL = dictionary[Key.DeliveryItem.imageUrl] as? String
            if let locationJson = dictionary[Key.DeliveryItem.location] as? [String: AnyObject],
                let locationItem = createLocationEntityFrom(dictionary: locationJson) as? Location {
                locationItem.deliveryItem = deliveryEntity
                deliveryEntity.location = locationItem
            }
            return deliveryEntity
        }
        return nil
    }

    private func createLocationEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        if let locationEntity = NSEntityDescription.insertNewObject(forEntityName:
            String(describing: Location.self), into: context) as? Location {
            locationEntity.lat = dictionary[Key.Location.lat] as? Double ?? 0
            locationEntity.lng = dictionary[Key.Location.lng] as? Double ?? 0
            locationEntity.address = dictionary[Key.Location.address] as? String
            locationEntity.deliveryItem = nil
            return locationEntity
        }
        return nil
    }

    // MARK: - Fetch Controller
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: DeliveryItem.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: Key.DeliveryItem.id, ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreDataStack.shared.persistentContainer.viewContext,
                                             sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()

    // MARK: - Clear Data
    func clearAllData() {
        clearData(entityName: String(describing: DeliveryItem.self))
        clearData(entityName: String(describing: Location.self))
    }

    private func clearData(entityName: String) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let objects  = try? context.fetch(fetchRequest) as? [NSManagedObject]
        _ = objects.map { $0.map { context.delete($0) } }
        CoreDataStack.shared.saveContext()
    }
}
