//
//  Delivery.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 09/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation

struct Delivery: Codable {
    let id: Int
    let desc: String
    let imageURL: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case id
        case desc = "description"
        case imageURL = "imageUrl"
        case location
    }
}
