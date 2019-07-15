//
//  DeliveryViewModelTest.swift
//  DeliveryAppTests
//
//  Created by abhisheksingh03 on 15/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import XCTest
import MapKit
@testable import DeliveryApp

class DeliveryViewModelTest: XCTestCase {

    var deliveryViewModel: DeliveryViewModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let delivery = createDummyDelivery()
        deliveryViewModel = DeliveryViewModel(item: delivery)
    }

    func createDummyDelivery() -> Delivery {
        let location = Location(lat: 26.2200134, lng: 80.92220012, address: "Lucknow City")
        let delivery = Delivery(id: 0, desc: "Dummy Description", imageURL: "Dummu URL", location: location)
        return delivery
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        deliveryViewModel = nil
    }

    func testRequiredElementShouldNotNil() {
        XCTAssertNotNil(deliveryViewModel)
    }

    func testSetDeliveryItem() {
        let delivery = createDummyDelivery()
        let dummyViewModel = DeliveryViewModel(item: delivery)
        XCTAssertEqual(deliveryViewModel!.itemId, dummyViewModel.itemId)
    }

    func testMKAnnotationProtocol () {
        XCTAssertTrue(deliveryViewModel.conforms(to: MKAnnotation.self))
        //XCTAssertEqual(deliveryListVC.observers.count, 2)
    }

    func testTitleText() {
        let delivery = createDummyDelivery()
        let dummyViewModel = DeliveryViewModel(item: delivery)
        XCTAssertEqual(dummyViewModel.title, delivery.location.address)
    }

    func testSubTitleText() {
        let delivery = createDummyDelivery()
        let dummyViewModel = DeliveryViewModel(item: delivery)
        XCTAssertEqual(dummyViewModel.subtitle, delivery.desc)
    }
}
