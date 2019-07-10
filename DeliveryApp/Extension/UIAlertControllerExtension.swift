//
//  UIAlertControllerExtension.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 04/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//
import UIKit

extension UIAlertController {
    class func getAlert(title: String? = StaticString.titleText,
                        message: String?,
                        dismissTitle: String? = StaticString.dismissText,
                        dismissAction: (() -> Void)? = nil) -> UIAlertController {
        // create alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: dismissTitle, style: .default, handler: { (_) in
            dismissAction?()
        }))
        return alertController
    }
}
