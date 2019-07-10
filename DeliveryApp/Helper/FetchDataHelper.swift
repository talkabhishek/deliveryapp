//
//  FetchDataHelper.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 10/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
struct FetchDataHelper {
    private init() { }
    static let shared = FetchDataHelper()

    func getDeliveries(offset: Int,
                       completion: @escaping(([Delivery]) -> Swift.Void),
                       errorCompletion: @escaping((ErrorResponse) -> Swift.Void)) {

        if DatabaseHelper.shared.getDeliveryCount() > offset {
            DatabaseHelper.shared.getDeliveries(offset: offset,
                                                completion: completion,
                                                errorCompletion: errorCompletion)
        } else {
            APIHelper.shared.getDeliveries(offset: offset, completion: { (deliveries) in
                completion(deliveries)
                DatabaseHelper.shared.saveInCoreData(array: deliveries)
            }, errorCompletion: errorCompletion)
        }
    }

}
