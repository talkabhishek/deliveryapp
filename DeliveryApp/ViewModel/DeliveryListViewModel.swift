//
//  DeliveryListViewModel.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 08/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import CoreData

class DeliveryListViewModel: NSObject {

    // MARK: - Instance variables
    private(set) var deliveryViewModels: [DeliveryViewModel] = [DeliveryViewModel]()
    var isLoading = false

    override init() {
        super.init()
    }

    // Get data action
    func getDeliveries(offset: Int, completion: @escaping((ErrorResponse?) -> Swift.Void)) {
        if isLoading {
            completion(nil)
        } else {
            isLoading = true
            FetchDataHelper.shared.getDeliveries(offset: offset, completion: { (deliveries) in
                self.setListValues(deliveries: deliveries)
                self.isLoading = false
                completion(nil)
            }, errorCompletion: { (error) in
                self.isLoading = false
                completion(error)
            })
        }
    }

    // Clear data action
    func clearList() {
        DatabaseHelper.shared.clearData()
        deliveryViewModels = []
    }

    func saveData(deliveries: [Delivery]) {
        DatabaseHelper.shared.saveInCoreData(array: deliveries)
    }

    // fetch data from Database
    func setListValues(deliveries: [Delivery]) {
        let dvm = deliveries.map {DeliveryViewModel(item: $0) }
        deliveryViewModels += dvm
    }
}
