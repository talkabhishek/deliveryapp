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
}
struct StaticString {
    static let deliveryListView = NSLocalizedString("Things to Deliver", comment: "")
    static let delivertDetailView = NSLocalizedString("Delivery Details", comment: "")
    static let titleText = NSLocalizedString("DeliveryApp", comment: "")
    static let dismissText  = NSLocalizedString("Ok", comment: "")
}
struct Key {
    struct DeliveryItem {
        static let id = "id"
        static let description = "description"
        static let imageUrl = "imageUrl"
        static let location = "location"
    }
    struct Location {
        static let address = "address"
        static let lat = "lat"
        static let lng = "lng"
    }
}
