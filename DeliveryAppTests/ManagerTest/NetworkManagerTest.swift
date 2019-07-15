//
//  NetworkManagerTest.swift
//  DeliveryAppTests
//
//  Created by abhisheksingh03 on 15/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import DeliveryApp

class NetworkManagerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func stubRequest(host: String, responseFile: String) {
        stub(condition: isHost(host)) { (_) -> OHHTTPStubsResponse in
            let stubPath = OHPathForFile(responseFile, type(of: self))!
            return fixture(filePath: stubPath, headers: ["Content-Type": "application/json"])
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeliveryForSuccessResponse() {
        let host = "mock-api-mobile.dev.lalamove.com"
        let responseFile = "SuccessResponse.json"
        stubRequest(host: host, responseFile: responseFile)

        let responseExpectation = expectation(description: "return expected data of List")
        APIServiceManager().getDeliveryList(offset: 0, limit: 20) { (response) in
            switch response {
            case .success(let items):
                XCTAssertNotNil(items, "list: expected result achived")
                XCTAssertEqual(10, items.count)
                responseExpectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error, "error: Expectation fulfilled with error")
            }
        }
        waitForExpectations(timeout: 50) { error in
            if let error = error {
                XCTAssertNotNil(error, "Failed to get response from list webservice")
            }
        }
    }

    func testDeliveryForErrorResponse() {
        let host = "mock-api-mobile.dev.lalamove.com"
        let responseFile = "ErrorResponse.json"
        stubRequest(host: host, responseFile: responseFile)

        let responseExpectation = expectation(description: "return expected data of List")
        APIServiceManager().getDeliveryList(offset: 0, limit: 20) { (response) in
            switch response {
            case .success( let item):
                XCTAssertNil(item, "error: item should be nil")
            case .failure(let error):
                XCTAssertNotNil(error, "error: Expectation fulfilled with error")
                responseExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 50) { error in
            if let error = error {
                XCTAssertNotNil(error, "Failed to get response from list webservice")
            }
        }
    }

}
