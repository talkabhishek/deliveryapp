//
//  DeliveryCellView.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 10/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit

class DeliveryItemView: UIView {

    var deliveryItem: DeliveryViewModel? {
        didSet {
            self.deliveryItemImage.setImageWith(URL: deliveryItem?.imageURL ?? "")
            self.deliveryItemLabel.text = deliveryItem?.description
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

    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.borderColor = ColorConstant.appTheme.cgColor
        self.layer.borderWidth = 0.5
        self.addSubview(deliveryItemImage)
        self.addSubview(deliveryItemLabel)
        setupViewConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewConstraints() {
        let marginGuide = self.layoutMarginsGuide
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
