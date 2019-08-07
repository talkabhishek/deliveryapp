//
//  Constant.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 09/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import UIKit

struct XCDataModel {
    static let name = "DeliveryApp"
}

struct Pagination {
    static let limit = 20
}

struct ViewConstant {
    static let cornerRadius: CGFloat = 5.0
    static let padding: CGFloat = 15
}

struct ColorConstant {
    static let appTheme: UIColor = UIColor(red: 175 / 255.0,
                                           green: 75 / 255.0,
                                           blue: 75 / 255.0,
                                           alpha: 1.0)
    static let navigationTint: UIColor = .white
}

struct FontConstant {
    static let systemRegular = UIFont.systemFont(ofSize: 18)
    static let systemBold = UIFont.boldSystemFont(ofSize: 20)
}
