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
    func saveInCoreData(array: [Delivery]) {
        DispatchQueue.global(qos: .background).async {
            _ = array.map { self.createDeliveryItem(From: $0) }
            try? CoreDataStack.shared.persistentContainer.viewContext.save()
        }
    }

    func createDeliveryItem(From item: Delivery?) -> DeliveryItem? {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        if let deliveryEntity = NSEntityDescription.insertNewObject(forEntityName:
            String(describing: DeliveryItem.self), into: context) as? DeliveryItem {
            deliveryEntity.id = Int32(item?.id ?? 0)
            deliveryEntity.desc = item?.desc
            deliveryEntity.imageURL = item?.imageURL
            deliveryEntity.locationItem = createLocationItem(From: item?.location)
        }
        return nil
    }

    func createLocationItem(From item: Location?) -> LocationItem? {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        if let locationEntity = NSEntityDescription.insertNewObject(forEntityName:
            String(describing: LocationItem.self), into: context) as? LocationItem {
            locationEntity.lat = item?.lat ?? 0
            locationEntity.lng = item?.lng ?? 0
            locationEntity.address = item?.address
            locationEntity.deliveryItem = nil
            return locationEntity
        }
        return nil
    }

    // Get Delivery Count
    func getDeliveryCount() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDesc = NSEntityDescription.entity(forEntityName: String(describing: DeliveryItem.self), in:
            CoreDataStack.shared.persistentContainer.viewContext)
        fetchRequest.entity = entityDesc
        let count = try? CoreDataStack.shared.persistentContainer.viewContext.count(for: fetchRequest)
        return count ?? 0
    }

    // MARK: - Clear Data
    func clearAllData() {
        DispatchQueue.global(qos: .background).async {
            self.clearData(entityName: String(describing: DeliveryItem.self))
            self.clearData(entityName: String(describing: LocationItem.self))
        }
    }

    // Clear data for Entity
    private func clearData(entityName: String) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let objects  = try? context.fetch(fetchRequest) as? [NSManagedObject]
        _ = objects.map { $0.map { context.delete($0) } }
        CoreDataStack.shared.saveContext()
    }

    func getDeliveries(page: Int,
                       completion: @escaping(([Delivery]) -> Swift.Void),
                       errorCompletion: @escaping((ErrorResponse) -> Swift.Void)) {
        DispatchQueue.global(qos: .background).async {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
            fetchRequest.fetchLimit = DeliveriesRequest.limit
            fetchRequest.fetchOffset = page * DeliveriesRequest.limit
            let entityDesc = NSEntityDescription.entity(forEntityName: String(describing: DeliveryItem.self), in:
                CoreDataStack.shared.persistentContainer.viewContext)
            fetchRequest.entity = entityDesc
            let fetchedOjects = try? CoreDataStack.shared.persistentContainer.viewContext.fetch(fetchRequest)
            guard let deliveriesItem = fetchedOjects as? [DeliveryItem] else {
                DispatchQueue.main.async {
                    errorCompletion(ErrorResponse(error: NetworkError.serverError("No Data")))
                }
                return
            }
            var deliveries = deliveriesItem.map { Utilities.shared.createDelivery(From: $0) }
            deliveries.sort { (item1, item2) -> Bool in
                return item1.id < item2.id
            }
            DispatchQueue.main.async {
                completion(deliveries)
            }
        }
    }
}
