//
//  UIMapViewExtension.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 15/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    func centerMapOn(coordinate: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        self.setRegion(coordinateRegion, animated: true)
    }
}
