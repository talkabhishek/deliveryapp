//
//  DeliverItemTableViewCell.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 05/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit

class DeliverItemTableViewCell: UITableViewCell {
    // Class identifier in Storyboard
    class var identifier: String {
        return String(describing: self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 10, y: 10, width: 100, height: 80)
        self.textLabel?.frame = CGRect(x: 120, y: 10, width: self.frame.width - 130, height: 80)
        self.textLabel?.numberOfLines = 2
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }

    func configureWith(Item item: DeliveryViewModel) {
        self.imageView?.setImageWith(URL: item.imageURL)
        self.textLabel?.text = "\(item.itemId): \(item.description)"
    }

}
