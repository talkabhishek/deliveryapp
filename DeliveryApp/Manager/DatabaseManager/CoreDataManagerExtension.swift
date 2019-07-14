//
//  CoreDataManagerExtension.swift
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
    func saveInCoreData(array: [Delivery])
    func getDeliveryList(offset: Int, limit: Int) -> [Delivery]
}

extension CoreDataManager: CoreDataManagerProtocol {
    // MARK: - Clear Data for Entity
    func clearData() {
        let entityName: String = String(describing: DeliveryItem.self)
        let context = CoreDataManager.shared.backgroundContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try CoreDataManager.shared.persistentContainer
                .persistentStoreCoordinator.execute(deleteRequest, with: context)
        } catch {
            debugPrint("There is an error in deleting records")
        }
    }

    // Get Delivery Count
    func getDeliveryCount() -> Int {
        let context = CoreDataManager.shared.backgroundContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDesc = NSEntityDescription.entity(forEntityName: String(describing: DeliveryItem.self), in:
            context)
        fetchRequest.entity = entityDesc
        let count = try? context.count(for: fetchRequest)
        return count ?? 0
    }

    // MARK: - Save list to Core Data
    func saveInCoreData(array: [Delivery]) {
        let context = CoreDataManager.shared.backgroundContext
        _ = array.map { self.createDeliveryItem(item: $0, context: context) }
        saveContext(context: context)
        //try? context.save()
    }

    func getDeliveryList(offset: Int, limit: Int) -> [Delivery] {
        let context = CoreDataManager.shared.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = limit
        let entityDesc = NSEntityDescription.entity(forEntityName: String(describing: DeliveryItem.self), in: context)
        fetchRequest.entity = entityDesc
        let fetchedOjects = try? context.fetch(fetchRequest)
            as? [DeliveryItem]
        var deliveries = fetchedOjects?.map { createDelivery(From: $0) }
        deliveries?.sort { (item1, item2) -> Bool in
            return item1.id < item2.id
        }
        return deliveries ?? []
    }

    // Helper methods
    private func createDeliveryItem(item: Delivery?, context: NSManagedObjectContext) -> DeliveryItem? {
        if let deliveryEntity = NSEntityDescription.insertNewObject(forEntityName:
            String(describing: DeliveryItem.self), into: context) as? DeliveryItem {
            deliveryEntity.id = Int32(item?.id ?? 0)
            deliveryEntity.desc = item?.desc
            deliveryEntity.imageURL = item?.imageURL
            deliveryEntity.locationItem = createLocationItem(item: item?.location, context: context)
        }
        return nil
    }

    private func createLocationItem(item: Location?, context: NSManagedObjectContext) -> LocationItem? {
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

    private func createDelivery(From item: DeliveryItem?) -> Delivery {
        return Delivery(id: Int(item?.id ?? 0),
                        desc: item?.desc ?? "",
                        imageURL: item?.imageURL ?? "",
                        location: createLocation(From: item?.locationItem))
    }

    private func createLocation(From item: LocationItem?) -> Location {
        return Location(lat: item?.lat ?? 0, lng: item?.lng ?? 0, address: item?.address ?? "")
    }

}