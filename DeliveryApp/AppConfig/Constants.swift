//
//  URLConstants.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 04/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation

struct AppURL {
    static let baseURL = "https://mock-api-mobile.dev.lalamove.com"
}

struct PersistentContainer {
    static let name = "DeliveryApp"
}

struct DeliveriesRequest {
    static let path = "/deliveries"
    struct Param {
        static let limit = "limit"
        static let offset = "offset"
    }
    static let limit = 10
}

struct StaticString {
    static let deliveryListView = NSLocalizedString("Things to Deliver", comment: "")
    static let delivertDetailView = NSLocalizedString("Delivery Details", comment: "")
    static let titleText = NSLocalizedString("DeliveryApp", comment: "")
    static let dismissText  = NSLocalizedString("Ok", comment: "")
}
