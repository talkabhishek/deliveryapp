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

    var deliveryListViewModel: DeliveryListViewModel!

    override func setUp() {
        super.setUp()
        deliveryListViewModel = DeliveryListViewModel()
    }

    override func tearDown() {
        deliveryListViewModel = nil
        super.tearDown()
    }

//    func testDeliveriesResponseCount() {
//        let params: [String: Any] = [Pagination.Param.limit: 10,
//                                     Pagination.Param.offset: 0]
//        let promise = expectation(description: "Response count is limit")
//        APIHelper.shared.deliveries(params: params) { (result) in
//            switch result {
//            case .success(let value):
//                if let list = value as? [[String: AnyObject]], list.count == 10 {
//                    promise.fulfill()
//                } else {
//                    XCTFail("Error: Parsing")
//                }
//            case .failure(let networkError):
//                XCTFail("Error: \(networkError.localizedDescription)")
//            }
//        }
//        wait(for: [promise], timeout: 10)
//    }

//    func testClearData() {
//        deliveryListViewModel.clearList()
//        let count = deliveryListViewModel.deliveryViewModels.count
//        XCTAssertEqual(count, 0, "Delivery count should be zero")
//    }

//    func testSaveData() {
//        deliveryListViewModel.clearList()
//        let testBundle = Bundle(for: type(of: self))
//        let path = testBundle.path(forResource: "SuccessResponse", ofType: "json")
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
//            let deliveries = try Utilities.shared.decode([Delivery].self, from: data)
//            DatabaseHelper.shared.saveInCoreData(array: deliveries)
//        } catch let error {
//            XCTFail(error.localizedDescription)
//        }
//        DispatchQueue.global().asyncAfter(deadline: .now()+1.0) {
//            let count = self.deliveryListViewModel.deliveryViewModels.count
//            XCTAssertEqual(10, count, "Delivery count should be 10")
//        }
//    }
//
//    func testRefershList() {
//        let promise = expectation(description: "Response count is 10 after refresh")
//        deliveryListViewModel.refreshList { (error) in
//            if let error = error {
//                XCTFail(error.message)
//            } else {
//                if self.deliveryListViewModel.deliveryViewModels.count == 10 {
//                    promise.fulfill()
//                } else {
//                    XCTFail("Error: Count not equal")
//                }
//            }
//        }
//        wait(for: [promise], timeout: 25)
//    }
//
//    func testLoadMoreData() {
//        let promise = expectation(description: "Response should increase by 10")
//        let count = deliveryListViewModel.deliveryViewModels.count
//        deliveryListViewModel.loadMore(With: count/10) { (error) in
//            if let error = error {
//                XCTFail(error.message)
//            } else {
//                if self.deliveryListViewModel.deliveryViewModels.count >= 10 {
//                    promise.fulfill()
//                } else {
//                    XCTFail("Error: Count not as expected")
//                }
//            }
//        }
//        wait(for: [promise], timeout: 30)
//    }
//
//    func testFailedApi() {
//        let promise = expectation(description: "Failed API")
//        let result: Result<Any, NetworkError> = .failure(NetworkError.serverError("Internal Server Error"))
//        Utilities.shared.parseAPIResponse(result, type: [Delivery].self, completion: { (_) in
//            XCTFail("Should get failed")
//        }, errorCompletion: { (_) in
//            promise.fulfill()
//        })
//        wait(for: [promise], timeout: 5)
//    }
//
//    func testFailedParshingData() {
//        let promise = expectation(description: "Failed Parsing")
//        let result: Result<Any, NetworkError> = .success(["response": "value"])
//        Utilities.shared.parseAPIResponse(result, type: [Delivery].self, completion: { (_) in
//            XCTFail("Should get failed")
//        }, errorCompletion: { (_) in
//            promise.fulfill()
//        })
//        wait(for: [promise], timeout: 5)
//    }
//
//    func testGetDeliveryError() {
//        deliveryListViewModel.clearList()
//        let promise = expectation(description: "Error Fetching")
//        DatabaseHelper.shared.getDeliveries(page: 0, completion: { (deliveries) in
//            print("111111111111: ", deliveries.count)
//            XCTFail("Should get failed")
//        }, errorCompletion: { (error) in
//            print(error.message)
//            promise.fulfill()
//        })
//        wait(for: [promise], timeout: 5)
//    }

}
