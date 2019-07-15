//
//  DeliveryListViewModelTest.swift
//  DeliveryAppTests
//
//  Created by abhisheksingh03 on 15/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import XCTest
import CoreData
@testable import DeliveryApp

class DeliveryListViewModelTest: XCTestCase {

    var deliveryListViewModel: DeliveryListViewModel!
    var mockCoreDataManager: MockCoreDataManager!
    var mockApiServiceManager: MockAPIServiceManager!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        deliveryListViewModel = DeliveryListViewModel()
        mockCoreDataManager = MockCoreDataManager()
        deliveryListViewModel.coreDataManager = mockCoreDataManager
        mockApiServiceManager = MockAPIServiceManager()
        deliveryListViewModel.apiServiceManager = mockApiServiceManager
    }

    func createDummyDelivery() -> Delivery {
        let location = Location(lat: 26.2200134, lng: 80.92220012, address: "Lucknow City")
        let delivery = Delivery(id: 0, desc: "Dummy Description", imageURL: "Dummu URL", location: location)
        return delivery
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        deliveryListViewModel = nil
        mockCoreDataManager = nil
        mockApiServiceManager = nil
    }

    func testLoadDataWithError() {
        mockCoreDataManager.isError = true
        mockApiServiceManager.isError = true
        deliveryListViewModel.getDeliveries()
        XCTAssertEqual(deliveryListViewModel!.deliveryViewModels.count, 0)
    }

    func testLoadDataWithSuccess() {
        deliveryListViewModel.getDeliveries()
        print(deliveryListViewModel!.deliveryViewModels.count)
        XCTAssertEqual(deliveryListViewModel!.deliveryViewModels.count, 1)
    }

    func testRefreshDataWithError() {
        mockCoreDataManager.isError = true
        mockApiServiceManager.isError = true
        deliveryListViewModel.getDeliveries(refresh: true)
        XCTAssertEqual(deliveryListViewModel!.deliveryViewModels.count, 0)
    }

    func testRefereshDataWithSuccess() {
        deliveryListViewModel.getDeliveries(refresh: true)
        print(deliveryListViewModel!.deliveryViewModels.count)
        XCTAssertEqual(deliveryListViewModel!.deliveryViewModels.count, 1)
    }

    func testClearData() {
        deliveryListViewModel.clearList()
        XCTAssertEqual(deliveryListViewModel!.deliveryViewModels.count, 0)
    }

    func testSaveData() {
        let delivery = createDummyDelivery()
        deliveryListViewModel.saveData(deliveries: [delivery])
        XCTAssertEqual(deliveryListViewModel!.coreDataManager.getDeliveryCount(), 1)
    }

    func testLoadDataFromDatabase() {
        let delivery = createDummyDelivery()
        deliveryListViewModel.saveData(deliveries: [delivery])
        deliveryListViewModel.getDeliveries()
        XCTAssertEqual(deliveryListViewModel!.deliveryViewModels.count, 1)
    }

}
