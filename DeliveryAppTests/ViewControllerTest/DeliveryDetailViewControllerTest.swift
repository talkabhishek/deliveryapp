//
//  DeliveryDetailViewControllerTest.swift
//  DeliveryAppTests
//
//  Created by abhisheksingh03 on 15/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import XCTest
import MapKit
@testable import DeliveryApp

class DeliveryDetailViewControllerTest: XCTestCase {

    var deliveryDetailVC: DeliveryDetailViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        deliveryDetailVC = DeliveryDetailViewController()
        let delivery = createDummyDelivery()
        deliveryDetailVC.deliveryItemViewModel = DeliveryViewModel(item: delivery)
        deliveryDetailVC.viewDidLoad()
    }

    func createDummyDelivery() -> Delivery {
        let location = Location(lat: 26.2200134, lng: 80.92220012, address: "Lucknow City")
        let delivery = Delivery(id: 0, desc: "Dummy Description", imageURL: "Dummu URL", location: location)
        return delivery
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        deliveryDetailVC = nil
    }

    func testRequiredElementShouldNotNil() {
        XCTAssertNotNil(deliveryDetailVC.navigationItem.title)
        XCTAssertNotNil(deliveryDetailVC.deliveryItemViewModel)
        XCTAssertNotNil(deliveryDetailVC.deliveryInfoView)
        XCTAssertNotNil(deliveryDetailVC.mapView)
    }

    func testMapViewDelegate () {
        XCTAssertTrue(deliveryDetailVC.conforms(to: MKMapViewDelegate.self))
    }

    func testMapViewAnnotation() {
        let mapView = deliveryDetailVC.mapView
        let annotationView = deliveryDetailVC.mapView(mapView!, viewFor: MKPointAnnotation())
        XCTAssertNotNil(annotationView)
    }

    func testAnnotationCount() {
        let mapView = deliveryDetailVC.mapView
        XCTAssertGreaterThan(mapView!.annotations.count, 0)
    }

}
