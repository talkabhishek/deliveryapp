//
//  MockAPIServiceManager.swift
//  DeliveryAppTests
//
//  Created by abhisheksingh03 on 15/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
@testable import DeliveryApp

class MockAPIServiceManager: APIServiceManagerProtocol {
    var isError = false

    func getDeliveryList(offset: Int, limit: Int, completion: @escaping (Callback<[Delivery]>)) {
        if isError {
            let error = NSError(domain: "Custom Error", code: 500, userInfo: nil)
            completion(.failure(error))
            return
        } else {
            let delivery = createDummyDelivery()
            completion(.success([delivery]))
        }
    }

    private func createDummyDelivery() -> Delivery {
        let location = Location(lat: 26.2200134, lng: 80.92220012, address: "Lucknow City")
        let delivery = Delivery(id: 0, desc: "Dummy Description", imageURL: "Dummu URL", location: location)
        return delivery
    }
}
