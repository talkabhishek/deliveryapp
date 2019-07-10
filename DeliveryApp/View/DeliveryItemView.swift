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
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let deliveryItemImage: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "placeholder"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.backgroundColor = .white
        self.addSubview(deliveryItemImage)
        self.addSubview(deliveryItemLabel)
        setupViewConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewConstraints() {
        let marginGuide = self.layoutMarginsGuide
        deliveryItemImage.translatesAutoresizingMaskIntoConstraints = false
        deliveryItemImage.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 0).isActive = true
        deliveryItemImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        deliveryItemImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        deliveryItemImage.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 5).isActive = true

        deliveryItemLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryItemLabel.leadingAnchor.constraint(
            equalTo: deliveryItemImage.trailingAnchor, constant: 20).isActive = true
        deliveryItemLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 5).isActive = true
        deliveryItemLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        deliveryItemLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -5).isActive = true
        deliveryItemLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
    }

}
