//
//  APIManager.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 13/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import Alamofire

typealias Callback<T> = (Result<T, Error>) -> Swift.Void

protocol APIServiceManagerProtocol {
    func getDeliveryList(offset: Int, limit: Int, completion: @escaping (Callback<[Delivery]>))
}

class APIServiceManager: APIServiceManagerProtocol {

    static let shared = APIServiceManager()
    private init() {}

    // MARK: - Root Methods
    private func sendWebRequest<T: Decodable>(
        service: APIService,
        completion: @escaping(Callback<T>)) {
        //Method body
        let url = service.baseUrl + service.path
        let request = AF.request(url, method: service.method,
                                 parameters: service.parameters,
                                 encoding: URLEncoding.queryString,
                                 headers: nil, interceptor: nil)
        request.responseDecodable { (response: DataResponse<T>) in
            completion(response.result)
        }
    }

    // MARK: - User API's
    func getDeliveryList(offset: Int, limit: Int, completion: @escaping (Callback<[Delivery]>)) {
        sendWebRequest(service: APIService.deliveries(offset: offset, limit:
            limit)) { (response: Result<[Delivery], Error>) in
            completion(response)
        }
    }
}
