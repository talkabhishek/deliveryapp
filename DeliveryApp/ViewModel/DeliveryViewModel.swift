//
//  DeliveryViewModel.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 10/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import MapKit

class DeliveryViewModel: NSObject {
    private let item: Delivery

    init(item: Delivery) {
        self.item = item
    }

    var imageURL: String {
        return item.imageURL
    }

    var itemId: String {
        return "\(item.id) "
    }

    override var description: String {
        return item.desc
    }
}
// Confirm MKAnnotation for Map
extension DeliveryViewModel: MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: item.location?.lat ?? 0, longitude: item.location?.lng ?? 0)
    }

    public var title: String? {
        return item.location?.address
    }

    public var subtitle: String? {
        return item.desc
    }
}
