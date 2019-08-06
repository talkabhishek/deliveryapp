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

struct StringConstant {
    static let deliveryListView = NSLocalizedString("Things to Deliver", comment: "")
    static let delivertDetailView = NSLocalizedString("Delivery Details", comment: "")
    static let titleText = NSLocalizedString("DeliveryApp", comment: "")
    static let dismissText = NSLocalizedString("Ok", comment: "")
    static let noDataFoundText = NSLocalizedString(#"""
                                No Data Found.
                                Pull down to refresh.
                                """#, comment: "")
}

struct ViewConstant {
    static let cornerRadius: CGFloat = 5.0
    static let zero: CGFloat = 0
    static let activityDimention: CGFloat = 50
    static let noDataLabelWidth: CGFloat = 300
    static let noDataLabelHeight: CGFloat = 500
}

struct ColorConstant {
    static let appTheme: UIColor = UIColor(red: 209.0 / 255.0,
                                           green: 138.0 / 255.0,
                                           blue: 48.0 / 255.0,
                                           alpha: 1.0)
    static let navigationTint: UIColor = .white
    static let noDataText: UIColor = .lightGray
    static let cellText: UIColor = .black
}

struct FontConstant {
    static let systemRegular = UIFont.systemFont(ofSize: 18)
    static let systemBold = UIFont.boldSystemFont(ofSize: 20)
}
