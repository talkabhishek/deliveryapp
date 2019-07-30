//
//  DeliveryCellView.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 10/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit

class DeliveryItemView: UIView {

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

    init(item: DeliveryViewModel) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.borderColor = ColorConstant.appTheme.cgColor
        self.layer.borderWidth = 0.5
        self.addSubview(deliveryItemImage)
        self.addSubview(deliveryItemDesc)
        self.addSubview(deliveryItemAddress)
        deliveryItemImage.setImageWith(URL: item.imageURL)
        deliveryItemDesc.text = item.desc
        deliveryItemAddress.text = item.address
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
        let imageBottomAnchor = deliveryItemImage.bottomAnchor
            //.constraint(greaterThanOrEqualTo: marginGuide.bottomAnchor, constant: -5)
            .constraint(equalTo: marginGuide.bottomAnchor, constant: -5)
        imageBottomAnchor.priority = UILayoutPriority(rawValue: 1000)
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
            //.constraint(greaterThanOrEqualTo: marginGuide.bottomAnchor, constant: -5)
            .constraint(equalTo: marginGuide.bottomAnchor, constant: -5)
            //.constraint(lessThanOrEqualTo: marginGuide.bottomAnchor, constant: 5)
        labelBottomAnchor.priority = UILayoutPriority(rawValue: 500)
        //labelBottomAnchor.isActive = true

    }

}
