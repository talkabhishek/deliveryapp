//
//  DeliveryTableViewCell.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 10/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit

class DeliveryTableViewCell: UITableViewCell {
    // Class identifier in Storyboard
    class var identifier: String {
        return String(describing: self)
    }

    private var deliveryInfoView: DeliveryItemView!

    var deliveryItem: DeliveryViewModel? {
        didSet {
            self.deliveryInfoView.deliveryItem = deliveryItem
        }
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // code common to all your cells goes here
        deliveryInfoView = DeliveryItemView()
        contentView.addSubview(deliveryInfoView)
        deliveryInfoView.fillSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
