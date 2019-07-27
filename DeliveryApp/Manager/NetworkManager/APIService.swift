//
//  APIService.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 13/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import Alamofire

enum APIService {
    var baseUrl: String { return Configuration.shared.env.baseURL }

    // Add all API as cases
    case deliveries(offset: Int, limit: Int)

    var path: String {
        switch self {
        case .deliveries:
            return "deliveries"
        }
    }

    var parameters: [String: Any] {
        switch self {
        case let .deliveries(offset, limit):
            var params: [String: Any] = ["offset": offset]
            params["limit"] = limit
            return params
        }
    }

    var method: HTTPMethod {
        switch self {
        case .deliveries:
            return .get
        }
    }
}
