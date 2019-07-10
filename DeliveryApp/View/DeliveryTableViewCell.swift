//
//  DeliveryTableViewCell.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 05/07/19.
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // code common to all your cells goes here
        contentView.addSubview(deliveryItemImage)
        contentView.addSubview(deliveryItemLabel)
        setupViewConstraints(marginGuide: contentView.layoutMarginsGuide)
    }

    init() {
        super.init(style: .default, reuseIdentifier: DeliveryTableViewCell.identifier)
        self.backgroundColor = .white
        self.addSubview(deliveryItemImage)
        self.addSubview(deliveryItemLabel)
        setupViewConstraints(marginGuide: self.layoutMarginsGuide)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupViewConstraints(marginGuide: UILayoutGuide) {
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

    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }

}
