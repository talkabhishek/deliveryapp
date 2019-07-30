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
                self.deliveryItemDesc.text = item.desc
                self.deliveryItemAddress.text = item.address
            }
        }
    }

    private let deliveryItemDesc: UILabel = {
        let label = UILabel()
        label.textColor = ColorConstant.cellText
        label.font = FontConstant.systemRegular
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let deliveryItemAddress: UILabel = {
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
        contentView.addSubview(deliveryItemDesc)
        contentView.addSubview(deliveryItemAddress)
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
        let imageBottomAnchor = deliveryItemImage.bottomAnchor
            .constraint(equalTo: marginGuide.bottomAnchor, constant: -5)
        imageBottomAnchor.priority = UILayoutPriority(rawValue: 500)
        imageBottomAnchor.isActive = true

        deliveryItemDesc.anchor(top: marginGuide.topAnchor,
                                 left: deliveryItemImage.rightAnchor,
                                 bottom: nil,
                                 right: marginGuide.rightAnchor,
                                 topConstant: 5,
                                 leftConstant: 20,
                                 bottomConstant: 0,
                                 rightConstant: 20,
                                 widthConstant: 0,
                                 heightConstant: 0)

        deliveryItemAddress.anchor(top: deliveryItemDesc.bottomAnchor,
                                left: deliveryItemImage.rightAnchor,
                                bottom: nil,
                                right: marginGuide.rightAnchor,
                                topConstant: 0,
                                leftConstant: 20,
                                bottomConstant: 0,
                                rightConstant: 20,
                                widthConstant: 0,
                                heightConstant: 0)

        let labelBottomAnchor = deliveryItemAddress.bottomAnchor
            .constraint(greaterThanOrEqualTo: marginGuide.bottomAnchor, constant: -5)
        labelBottomAnchor.priority = UILayoutPriority(rawValue: 1000)
        //labelBottomAnchor.isActive = true
    }

}
