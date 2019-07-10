//
//  UIImageViewExtension.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 04/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func setImageWith(URL urlString: String, placeHolder: UIImage? = UIImage(named: "placeholder")) {
        self.sd_setImage(with: URL(string: urlString),
                         placeholderImage: placeHolder,
                         options: .continueInBackground,
                         completed: nil)
    }
}
