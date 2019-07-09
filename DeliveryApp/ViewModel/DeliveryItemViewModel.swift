//
//  DeliveryItemViewModel.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 08/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import MapKit

class DeliveryItemViewModel: NSObject {
    let item: DeliveryItem

    init(item: DeliveryItem) {
        self.item = item
    }

    var itemId: Int {
        return Int(item.id)
    }

    var imageURL: String? {
        return item.imageURL
    }

    override var description: String {
        return item.desc ?? super.description
    }

}
extension DeliveryItemViewModel: MKAnnotation {
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
