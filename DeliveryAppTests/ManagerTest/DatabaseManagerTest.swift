//
//  DatabaseManagerTest.swift
//  DeliveryAppTests
//
//  Created by abhisheksingh03 on 15/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import XCTest
import CoreData
@testable import DeliveryApp

class DatabaseManagerTest: XCTestCase {

    var coreDataManager: CoreDataManager!

    private lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()

    private lazy var mockPersistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: XCDataModel.name)
//        let description = NSPersistentStoreDescription()
//        description.type = NSInMemoryStoreType
//        description.shouldAddStoreAsynchronously = false
//        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores(completionHandler: { (description, error) in
            // Check if the data store is in memory
//            precondition( description.type == NSInMemoryStoreType )
            // Check if creating container wrong
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreDataManager = CoreDataManager()
        coreDataManager.stack.persistentContainer = mockPersistentContainer
    }

    func createDummyDelivery() -> Delivery {
        let location = Location(lat: 26.2200134, lng: 80.92220012, address: "Lucknow City")
        let delivery = Delivery(id: 0, desc: "Dummy Description", imageURL: "Dummu URL", location: location)
        return delivery
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        coreDataManager = nil
    }

    func testCheckEmpty() {
        if let manager = coreDataManager {
            let count = manager.getDeliveryCount()
            XCTAssertEqual(count, 0)
        } else {
            XCTFail("Core data manager is nil")
        }
    }

    func testGetDeliveriesWithEmptyData() {
        let deliveries = coreDataManager.getDeliveryList(offset: 0, limit: 20)
        XCTAssertEqual(deliveries.count, 0)
    }

    // delete query can not work with in memory storage
    func testClearAllData() {
        let delivery = createDummyDelivery()
        coreDataManager.saveInCoreData(array: [delivery])
        coreDataManager.clearData()
        let count = coreDataManager.getDeliveryCount()
        XCTAssertEqual(count, 0)
    }

    func testSaveData() {
        let delivery = createDummyDelivery()
        coreDataManager.saveInCoreData(array: [delivery])
        let count = coreDataManager.getDeliveryCount()
        XCTAssertEqual(count, 1)
    }

    func testGetDeliveriesWithData() {
        let delivery = createDummyDelivery()
        coreDataManager.saveInCoreData(array: [delivery])
        let deliveries = coreDataManager.getDeliveryList(offset: 0, limit: 20)
        XCTAssertEqual(deliveries.count, 1)
    }

}
