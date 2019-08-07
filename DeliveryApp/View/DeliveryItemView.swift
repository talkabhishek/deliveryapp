//
//  DeliveryCellView.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 10/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import UIKit

class DeliveryItemView: UIView {

    struct Constant {
        static let size: CGFloat = 70
        static let padding: CGFloat = ViewConstant.padding
        static let borderWidth: CGFloat = 0.5
        static let borderColor: UIColor = ColorConstant.appTheme
        static let textColor: UIColor = .black
        static let textFont: UIFont = FontConstant.systemRegular
        static let cornerRadius: CGFloat = ViewConstant.cornerRadius
    }

    var deliveryItem: DeliveryViewModel? {
        didSet {
            self.deliveryItemImage.setImageWith(URL: deliveryItem?.imageURL ?? "")
            self.deliveryItemLabel.text = deliveryItem?.description
        }
    }

    private let deliveryItemLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constant.textColor
        label.font = Constant.textFont
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let deliveryItemImage: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "placeholder"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = Constant.cornerRadius
        return imgView
    }()

    init(item: DeliveryViewModel) {
        super.init(frame: CGRect.zero)
        self.layer.cornerRadius = Constant.cornerRadius
        self.layer.borderColor = Constant.borderColor.cgColor
        self.layer.borderWidth = Constant.borderWidth
        initializeSubViews()
        deliveryItemImage.setImageWith(URL: item.imageURL)
        deliveryItemLabel.text = item.description
    }

    init() {
        super.init(frame: CGRect.zero)
        initializeSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeSubViews() {
        self.backgroundColor = .white
        self.addSubview(deliveryItemImage)
        self.addSubview(deliveryItemLabel)
        setupViewConstraints()
    }

    func setupViewConstraints() {
        deliveryItemImage.anchor(top: topAnchor,
                                 left: leftAnchor,
                                 paddingTop: Constant.padding,
                                 paddingLeft: Constant.padding,
                                 widthConstant: Constant.size,
                                 heightConstant: Constant.size)

        deliveryItemLabel.anchor(top: topAnchor,
                                 left: deliveryItemImage.rightAnchor,
                                 bottom: bottomAnchor,
                                 right: rightAnchor,
                                 paddingTop: Constant.padding,
                                 paddingLeft: Constant.padding,
                                 paddingBottom: Constant.padding,
                                 paddingRight: Constant.padding)

        deliveryItemLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Constant.size).isActive = true
    }

}
