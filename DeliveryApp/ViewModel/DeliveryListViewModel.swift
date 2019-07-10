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
    var hasMoreData = true
    var isLoading = false
    var isWorking = false

    override init() {
        super.init()
    }

    // Bind data initially
    func bindListItems(completion: @escaping((ErrorResponse?) -> Swift.Void)) {
        isWorking = true
        Utilities.shared.getDeliveries(page: 0, completion: { (deliveries) in
            print(deliveries.count)
            //self.saveData(deliveries: deliveries)
            self.setListValues(deliveries: deliveries)
            self.isWorking = false
            completion(nil)
        }, errorCompletion: { (error) in
            self.isWorking = false
            completion(error)
        })
    }

    // Pull to referesh action
    func refreshList(completion: @escaping((ErrorResponse?) -> Swift.Void)) {
        APIHelper.shared.getDeliveries(page: 0, completion: { (deliveries) in
            print(deliveries.count)
            self.clearList()
            self.saveData(deliveries: deliveries)
            self.setListValues(deliveries: deliveries)
            self.hasMoreData = true
            self.isWorking = false
            completion(nil)
        }, errorCompletion: { (error) in
            self.isWorking = false
            completion(error)
        })
    }

    // Clear data action
    func clearList() {
        DatabaseHelper.shared.clearAllData()
        deliveryViewModels = []
    }

    func saveData(deliveries: [Delivery]) {
        DatabaseHelper.shared.saveInCoreData(array: deliveries)
    }

    // Load more data
    func loadMore(With pageNo: Int, completion: @escaping((ErrorResponse?) -> Swift.Void)) {
        if !hasMoreData || isWorking {
            completion(nil)
        } else {
            isWorking = true
            Utilities.shared.getDeliveries(page: pageNo, completion: { (deliveries) in
                print(deliveries.count)
                if deliveries.count < DeliveriesRequest.limit {
                    self.hasMoreData = false
                }
                //self.saveData(deliveries: deliveries)
                self.setListValues(deliveries: deliveries)
                self.isWorking = false
                completion(nil)
            }, errorCompletion: { (error) in
                self.isWorking = false
                completion(error)
            })
        }
    }

    // fetch data from Database
    func setListValues(deliveries: [Delivery]) {
        let dvm = deliveries.map {DeliveryViewModel(item: $0) }
        deliveryViewModels += dvm
    }
}
