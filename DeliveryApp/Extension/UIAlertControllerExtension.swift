//
//  UIAlertControllerExtension.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 04/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func getAlert(title: String? = nil, message: String?,
                        dismissTitle: String? = nil, dismissAction: (() -> Void)? = nil) -> UIAlertController {
        // create alert controller
        var titleText = StaticString.titleText
        var dismissText  = StaticString.dismissText
        if title != nil {
            titleText = title ?? ""
        }
        if dismissTitle != nil {
            dismissText = dismissTitle ?? ""
        }
        let alertController = UIAlertController(title: titleText, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: dismissText, style: .default, handler: { (_) in
            dismissAction?()
        }))
        return alertController
    }
}
