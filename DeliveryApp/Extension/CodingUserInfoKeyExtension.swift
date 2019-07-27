//
//  CodingUserInfoKeyExtension.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 26/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
