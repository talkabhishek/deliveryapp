//
//  DeliveryListViewControllerTest.swift
//  DeliveryAppTests
//
//  Created by abhisheksingh03 on 15/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import XCTest
@testable import DeliveryApp

class DeliveryListViewControllerTest: XCTestCase {

    var deliveryListVC: DeliveryListViewController!
    var navigationController: AppNavigationController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let navController = appDelegate.window?.rootViewController as? AppNavigationController,
            let viewController = navController.viewControllers.first as? DeliveryListViewController else {
            fatalError("No Application found")
        }
        navigationController = navController
        deliveryListVC = viewController
        deliveryListVC.viewDidLoad()
    }

    func createDummyDelivery() -> Delivery {
        let location = Location(lat: 26.2200134, lng: 80.92220012, address: "Lucknow City")
        let delivery = Delivery(id: 0, desc: "Dummy Description", imageURL: "Dummu URL", location: location)
        return delivery
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        deliveryListVC = nil
        navigationController = nil
    }

    func testRequiredElementSetup() {
        XCTAssertNotNil(deliveryListVC.navigationItem.title)
        XCTAssertNotNil(deliveryListVC.deliveryListViewModel)
        XCTAssertEqual(deliveryListVC.observers.count, 2)
    }

    func testTableViewDelegateDataSource() {
        XCTAssertTrue(deliveryListVC.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(deliveryListVC.conforms(to: UITableViewDataSource.self))
    }

    func testCellConfiguration() {
        let tableView = deliveryListVC.tableViewObject()
        let delivery = createDummyDelivery()
        deliveryListVC.deliveryListViewModel.deliveryViewModels = [DeliveryViewModel(item: delivery)]
        let cell = deliveryListVC.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }

    func testShouldNotShowNoResultMessage () {
        if deliveryListVC.deliveryListViewModel.deliveryViewModels.count > 0 {
            let tableView = deliveryListVC.tableViewObject()
            XCTAssertNil(tableView.tableHeaderView)
        }
    }

    func testShouldShowNoResultMessage () {
        deliveryListVC.updateUIOnResponse()
        if deliveryListVC.deliveryListViewModel.deliveryViewModels.count == 0 {
            let tableView = deliveryListVC.tableViewObject()
            XCTAssertNotNil(tableView.tableHeaderView)
        }
    }

    func testUpdateUI() {
        let delivery = createDummyDelivery()
        deliveryListVC.deliveryListViewModel.setListValues(deliveries: [delivery])
        deliveryListVC.updateUIOnResponse()
        let tableView = deliveryListVC.tableViewObject()
        XCTAssertNil(tableView.tableHeaderView)
    }

    func testUpdateUIOnError() {
        deliveryListVC.deliveryListViewModel.deliveryViewModels = []
        let error = NSError.init(domain: "Custom error", code: 500, userInfo: nil)
        deliveryListVC.updateUIOnResponse(error: error)
        let tableView = deliveryListVC.tableViewObject()
        XCTAssertNotNil(tableView.tableHeaderView)
    }

    func testControllerOnSelection() {
        let tableView = deliveryListVC.tableViewObject()
        let delivery = createDummyDelivery()
        deliveryListVC.deliveryListViewModel.deliveryViewModels = [DeliveryViewModel(item: delivery)]
        deliveryListVC.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(navigationController.viewControllers.last is DeliveryDetailViewController)
    }

}