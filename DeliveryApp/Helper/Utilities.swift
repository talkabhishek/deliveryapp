//
//  Utilities.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 09/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation

struct Utilities {
    private init() { }
    static let shared = Utilities()

    // Codable helper
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Codable {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch let error {
            throw error
        }
    }

    func decode<T>(_ type: T.Type, from json: Any) throws -> T where T: Codable {
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return try decode(type, from: data)
        } catch let error {
            throw error
        }
    }

    //Parsing Helper
    func parseAPIResponse<T>(_ response: Result<Any, NetworkError>,
                             type: T.Type,
                             completion: @escaping((T) -> Swift.Void),
                             errorCompletion: @escaping((ErrorResponse) -> Swift.Void))
        where T: Codable {
        switch response {
        case .success(let value):
            do {
                let resp = try decode(type, from: value)
                completion(resp)
            } catch let error {
                errorCompletion(ErrorResponse(error: error))
            }
        case .failure(let newworkError):
            errorCompletion(ErrorResponse(error: newworkError))
        }
    }

    func createDelivery(From item: DeliveryItem?) -> Delivery {
        return Delivery(id: Int(item?.id ?? 0),
                        desc: item?.desc ?? "",
                        imageURL: item?.imageURL ?? "",
                        location: createLocation(From: item?.locationItem))
    }

    func createLocation(From item: LocationItem?) -> Location {
        return Location(lat: item?.lat ?? 0, lng: item?.lng ?? 0, address: item?.address ?? "")
    }

    func getDeliveries(page: Int,
                       completion: @escaping(([Delivery]) -> Swift.Void),
                       errorCompletion: @escaping((ErrorResponse) -> Swift.Void)) {

        if DatabaseHelper.shared.getDeliveryCount() >=
            (page+1) * DeliveriesRequest.limit {
            DatabaseHelper.shared.getDeliveries(page: page, completion: completion, errorCompletion: errorCompletion)
        } else {
            APIHelper.shared.getDeliveries(page: page, completion: { (deliveries) in
                completion(deliveries)
                DatabaseHelper.shared.saveInCoreData(array: deliveries)
            }, errorCompletion: errorCompletion)
        }
    }

}
