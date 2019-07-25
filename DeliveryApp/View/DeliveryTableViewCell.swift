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

    var deliveryItem: DeliveryViewModel? {
        didSet {
            if let item = deliveryItem {
                self.deliveryItemImage.setImageWith(URL: item.imageURL)
                self.deliveryItemLabel.text = item.description
            }
        }
    }

    private let deliveryItemLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorConstant.cellText
        label.font = FontConstant.systemRegular
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let deliveryItemImage: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "placeholder"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 5
        return imgView
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // code common to all your cells goes here
        contentView.addSubview(deliveryItemImage)
        contentView.addSubview(deliveryItemLabel)
        setupViewConstraints(marginGuide: contentView.layoutMarginsGuide)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupViewConstraints(marginGuide: UILayoutGuide) {
        deliveryItemImage.anchor(top: marginGuide.topAnchor,
                                 left: marginGuide.leftAnchor,
                                 bottom: nil,
                                 right: nil,
                                 topConstant: 5,
                                 leftConstant: 5,
                                 bottomConstant: 0,
                                 rightConstant: 0,
                                 widthConstant: 70,
                                 heightConstant: 70)

        deliveryItemLabel.anchor(top: marginGuide.topAnchor,
                                 left: deliveryItemImage.rightAnchor,
                                 bottom: marginGuide.bottomAnchor,
                                 right: marginGuide.rightAnchor,
                                 topConstant: 0,
                                 leftConstant: 20,
                                 bottomConstant: 0,
                                 rightConstant: 0,
                                 widthConstant: 0,
                                 heightConstant: 0)

        deliveryItemLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
    }

}
