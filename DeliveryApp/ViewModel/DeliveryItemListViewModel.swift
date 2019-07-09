//
//  DeliveryItemListViewModel.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 08/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import CoreData

class DeliveryItemListViewModel: NSObject {

    // MARK: - Instance variables
    private(set) var deliveryItemViewModels: [DeliveryItemViewModel] = [DeliveryItemViewModel]()
    var hasMoreData = true
    var isLoading = false

    override init() {
        super.init()
        DatabaseHelper.shared.fetchedhResultController.delegate = self
    }

    // Bind data initially
    func bindListItems(completion: @escaping(() -> Swift.Void)) {
        try? DatabaseHelper.shared.fetchedhResultController.performFetch()
        if DatabaseHelper.shared.fetchedhResultController.sections?.first?.numberOfObjects == 0 {
            fetchAndSave(pageNo: 0, completion: completion)
        } else {
            setListValues()
            completion()
        }
    }

    // Pull to referesh action
    func refreshList(completion: @escaping(() -> Swift.Void)) {
        fetchList(pageNumber: 0) { (list) in
            self.clearList()
            DatabaseHelper.shared.saveInCoreDataWith(array: list)
            self.sortListWithId()
            self.hasMoreData = true
            completion()
        }
    }

    // Clear data action
    func clearList() {
        DatabaseHelper.shared.clearAllData()
        deliveryItemViewModels = []
    }

    // Load more data
    func loadMore(With pageNo: Int, completion: @escaping(() -> Swift.Void)) {
        if !hasMoreData {
            completion()
        } else {
            fetchAndSave(pageNo: pageNo, completion: completion)
        }
    }

    // get data from server and save
    func fetchAndSave(pageNo: Int, completion: @escaping(() -> Swift.Void)) {
        fetchList(pageNumber: pageNo) { (list) in
            DatabaseHelper.shared.saveInCoreDataWith(array: list)
            try? DatabaseHelper.shared.fetchedhResultController.performFetch()
            self.sortListWithId()
            completion()
        }
    }

    private func sortListWithId() {
        deliveryItemViewModels.sort { (item1, item2) -> Bool in
            return item1.itemId < item2.itemId
        }
    }

    // Fetch data from server
    private func fetchList(pageNumber: Int, completion: @escaping(([[String: AnyObject]]?) -> Swift.Void)) {
        if isLoading {
            completion(nil)
        } else {
            isLoading = true
            let params: [String: Any] = [DeliveriesRequest.Param.limit: 10,
                                         DeliveriesRequest.Param.offset: pageNumber * 10]
            APIHelper.shared.deliveries(params: params) { (result) in
                self.isLoading = false
                switch result {
                case .success(let value):
                    if let list = value as? [[String: AnyObject]] {
                        if list.count < 10 {
                            self.hasMoreData = false
                        }
                        completion(list)
                    } else {
                        completion(nil)
                    }
                case .failure(let networkError):
                    print(networkError.localizedDescription)
                    completion(nil)
                }
            }
        }
    }

    // fetch data from Database
    func setListValues() {
        if let items = (DatabaseHelper.shared.fetchedhResultController.sections![0].objects as? [DeliveryItem]) {
            for item in items {
                deliveryItemViewModels.append(DeliveryItemViewModel(item: item))
            }
        }
    }
}

// NSFetchedResultsControllerDelegate function
extension DeliveryItemListViewModel: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let item = anObject as? DeliveryItem {
                deliveryItemViewModels.append(DeliveryItemViewModel(item: item))
            }
        default:
            break
        }
    }
}
