//
//  DeliveryListViewModel.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 10/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import CoreData

class DeliveryListViewModel: NSObject {

    // MARK: - Instance variables
    @objc dynamic var deliveryViewModels = [DeliveryViewModel]()
    @objc dynamic var error: Error?

    private(set) var coreDataManager: CoreDataManagerProtocol = CoreDataManager()
    private(set) var apiServiceManager: APIServiceManagerProtocol = APIServiceManager()

    override init() {
        super.init()
    }

    // Get data action
    func getDeliveries(offset: Int = 0, refresh: Bool = false) {
        if coreDataManager.getDeliveryCount() > offset && !refresh {
            let deliveries = coreDataManager.getDeliveryList(offset:
                offset, limit: Pagination.limit)
            setListValues(deliveries: deliveries)
        } else {
            apiServiceManager.getDeliveryList(offset: offset, limit: Pagination.limit) { (response) in
                switch response {
                case .success(let value):
                    self.setListValues(deliveries: value, refresh: refresh)
                    self.coreDataManager.saveInCoreData(array: value)
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }

    // Clear data action
    func clearList() {
        coreDataManager.clearData()
        deliveryViewModels = []
    }

    // Save data action
    func saveData(deliveries: [Delivery]) {
        coreDataManager.saveInCoreData(array: deliveries)
    }

    // Set view model
    func setListValues(deliveries: [Delivery], refresh: Bool = false) {
        let dvm = deliveries.map {DeliveryViewModel(item: $0) }
        if refresh {
            coreDataManager.clearData()
            deliveryViewModels = dvm
        } else {
            deliveryViewModels += dvm
        }
    }
}
