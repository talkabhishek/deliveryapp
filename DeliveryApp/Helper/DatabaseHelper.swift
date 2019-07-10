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
        _ = array.map { self.createDeliveryItem(From: $0) }
        try? CoreDataStack.shared.persistentContainer.viewContext.save()
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

    func createDelivery(From item: DeliveryItem?) -> Delivery {
        return Delivery(id: Int(item?.id ?? 0),
                        desc: item?.desc ?? "",
                        imageURL: item?.imageURL ?? "",
                        location: createLocation(From: item?.locationItem))
    }

    func createLocation(From item: LocationItem?) -> Location {
        return Location(lat: item?.lat ?? 0, lng: item?.lng ?? 0, address: item?.address ?? "")
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

    // MARK: - Clear Data for Entity
    func clearData(entityName: String = String(describing: DeliveryItem.self)) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let objects  = try? context.fetch(fetchRequest) as? [NSManagedObject]
        _ = objects.map { $0.map { context.delete($0) } }
        CoreDataStack.shared.saveContext()
    }

    func getDeliveries(offset: Int,
                       completion: @escaping(([Delivery]) -> Swift.Void),
                       errorCompletion: @escaping((ErrorResponse) -> Swift.Void)) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.fetchLimit = DeliveriesRequest.limit
        fetchRequest.fetchOffset = offset
        let entityDesc = NSEntityDescription.entity(forEntityName: String(describing: DeliveryItem.self), in:
            CoreDataStack.shared.persistentContainer.viewContext)
        fetchRequest.entity = entityDesc
        let fetchedOjects = try? CoreDataStack.shared.persistentContainer.viewContext.fetch(fetchRequest)
        guard let deliveriesItem = fetchedOjects as? [DeliveryItem] else {
            errorCompletion(ErrorResponse(error: NetworkError.serverError(StaticString.noDataText)))
            return
        }
        var deliveries = deliveriesItem.map { createDelivery(From: $0) }
        deliveries.sort { (item1, item2) -> Bool in
            return item1.id < item2.id
        }
        completion(deliveries)
    }
}
