//
//  APIHelper.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 04/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import Alamofire

public enum NetworkError: Error {
    case serverError(String)
}

struct ErrorResponse {
    var message: String

    init(error: Error) {
        message = error.localizedDescription
    }

    init(error: NetworkError) {
        message = error.localizedDescription
        switch error {
        case .serverError(let errorMessage):
            message = errorMessage
        }
    }
}

//typealias JSONDictionary = [String: Any]
typealias APICallback = (Result<Any, NetworkError>) -> Swift.Void

struct APIHelper {

    private init() { }
    static var shared = APIHelper()
    let baseURL: String = AppURL.baseURL

    // MARK: - Root Methods
    func sendRequest(
        _ url: URL,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        completion: @escaping(APICallback)) {
        //Method body
        let request = AF.request(url, method: method,
                                 parameters: parameters,
                                 encoding: URLEncoding.queryString,
                                 headers: nil, interceptor: nil)
        request.responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(.serverError(error.localizedDescription)))
            }
        })
    }

    // MARK: - User API's
    func deliveries(params: [String: Any]?, completion: @escaping(APICallback)) {
        guard let url = URL(string: baseURL + DeliveriesRequest.path) else { return }
        sendRequest(url, method: .get, parameters: params, headers: nil, completion: completion)
    }

    func getDeliveries(page: Int,
                       completion: @escaping(([Delivery]) -> Swift.Void),
                       errorCompletion: @escaping((ErrorResponse) -> Swift.Void)) {
        let params: [String: Any] = [DeliveriesRequest.Param.limit: DeliveriesRequest.limit,
                                         DeliveriesRequest.Param.offset: page * DeliveriesRequest.limit]
        guard let url = URL(string: baseURL + DeliveriesRequest.path) else { return }
        sendRequest(url, method: .get, parameters: params, headers: nil) { (result) in
            Utilities.shared.parseAPIResponse(result, type: [Delivery].self,
                                              completion: completion,
                                              errorCompletion: errorCompletion)
        }
    }
}
