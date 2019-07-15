//
//  MockCoreDataManager.swift
//  DeliveryAppTests
//
//  Created by abhisheksingh03 on 15/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
@testable import DeliveryApp

class MockCoreDataManager: CoreDataManagerProtocol {
    var isError: Bool = false
    var deliveries: [Delivery] = []

    func clearData() {
        deliveries = []
    }

    func getDeliveryCount() -> Int {
        if isError {
            return 0
        }
        return deliveries.count
    }

    func saveInCoreData(array: [Delivery]) {
        deliveries = array
    }

    func getDeliveryList(offset: Int, limit: Int) -> [Delivery] {
        return deliveries
    }
}
