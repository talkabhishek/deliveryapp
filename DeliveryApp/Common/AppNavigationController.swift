//
//  AppNavigationController.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 09/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.tintColor = ColorConstant.navigationTint
        self.navigationBar.barTintColor = ColorConstant.appTheme
        // change navigation item title color
        self.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor:
            ColorConstant.navigationTint, NSAttributedString.Key.font: FontConstant.systemBold]
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
