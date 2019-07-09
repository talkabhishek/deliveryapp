//
//  DeliveryAppTests.swift
//  DeliveryAppTests
//
//  Created by abhisheksingh03 on 09/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import XCTest
@testable import DeliveryApp

class DeliveryAppTests: XCTestCase {

    var deliveryItemListViewModel: DeliveryItemListViewModel!

    override func setUp() {
        super.setUp()
        deliveryItemListViewModel = DeliveryItemListViewModel()
    }

    override func tearDown() {
        deliveryItemListViewModel = nil
        super.tearDown()
    }

    func testDeliveriesResponseCount() {
        let params: [String: Any] = [DeliveriesRequest.Param.limit: 10,
                                     DeliveriesRequest.Param.offset: 0]
        let promise = expectation(description: "Response count is limit")
        APIHelper.shared.deliveries(params: params) { (result) in
            switch result {
            case .success(let value):
                if let list = value as? [[String: AnyObject]], list.count == 10 {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Parsing")
                }
            case .failure(let networkError):
                XCTFail("Error: \(networkError.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 10)
    }

    func testClearData() {
        deliveryItemListViewModel.clearList()
        let count = deliveryItemListViewModel.deliveryItemViewModels.count
        XCTAssertEqual(count, 0, "Delivery count should be zero")
    }

    func testSaveData() {
        let count1 = deliveryItemListViewModel.deliveryItemViewModels.count

        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "response", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
            let jsonResponse = try JSONSerialization.jsonObject(with: data,
                                                                options:
                JSONSerialization.ReadingOptions.allowFragments)
            if let list = jsonResponse as? [[String: AnyObject]] {
                DatabaseHelper.shared.saveInCoreDataWith(array: list)
            }
        } catch { }
        let count2 = deliveryItemListViewModel.deliveryItemViewModels.count
        XCTAssertEqual(count1 + 10, count2, "Delivery count should increment by 10")
    }

    func testRefershList() {
        let promise = expectation(description: "Response count is 10 after refresh")
        deliveryItemListViewModel.refreshList {
            if self.deliveryItemListViewModel.deliveryItemViewModels.count == 10 {
                promise.fulfill()
            } else {
                print("------------------\(self.deliveryItemListViewModel.deliveryItemViewModels.count)")
                XCTFail("Error: Count not equal")
            }
        }
        wait(for: [promise], timeout: 25)
    }

    func testLoadMoreData() {
        let promise = expectation(description: "Response should increase by 10")
        deliveryItemListViewModel.clearList()
        let count1 = deliveryItemListViewModel.deliveryItemViewModels.count
        deliveryItemListViewModel.loadMore(With: count1/10) {
            if self.deliveryItemListViewModel.deliveryItemViewModels.count == count1 + 10 {
                promise.fulfill()
            } else {
                print("------------------\(self.deliveryItemListViewModel.deliveryItemViewModels.count)")
                XCTFail("Error: Count not as expected")
            }
        }
        wait(for: [promise], timeout: 30)
    }

}
