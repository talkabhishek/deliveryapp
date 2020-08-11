//
//  Configuration.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 13/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
// Singleton that defines the settings based on the environment/scheme/target
final class Configuration {

    private init() { }
    static let shared = Configuration()

    lazy var env: Environment = {
        #if DEVELOPMENT
        return Environment.development
        #elseif STAGING
        return Environment.staging
        #elseif PRODUCTION
        return Environment.production
        #endif
    }()
}

/*
 Open your Project Build Settings and search for “Swift Compiler – Custom Flags” … “Other Swift Flags”.
 Add “-DDEVELOPMENT” to the Debug section
 Add “-DPRODUCTION” to the Release section
 */
enum Environment: String {
    // Add each environment
    case development
    case staging
    case production

    // Create envrionment based computed property like baseURL, APIKeys
    var baseURL: String {
        switch self {
        case .development: return "https://mock-api-mobile.dev.lalamove.com/"
        case .staging: return "https://mock-api-mobile.dev.lalamove.com/"
        case .production: return "https://mock-api-mobile.dev.lalamove.com/"
        }
    }
}
