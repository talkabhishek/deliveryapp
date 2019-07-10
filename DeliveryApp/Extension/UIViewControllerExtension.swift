//
//  UIViewControllerExtension.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 04/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//
import UIKit

extension UIViewController {
    func showAlert(title: String? = nil, message: String?,
                   dismissTitle: String? = nil, dismissAction: (() -> Void)? = nil) {
        // Resign keyboard
        self.view.endEditing(true)
        UIApplication.shared.sendAction(#selector(self.resignFirstResponder), to: nil, from: nil, for: nil)
        // create alert controller
        let alertController = UIAlertController.getAlert(title: title,
                                                         message: message,
                                                         dismissTitle: dismissTitle,
                                                         dismissAction: dismissAction)
        // present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
}
