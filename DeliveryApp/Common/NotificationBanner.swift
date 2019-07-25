//
//  NotificationBanner.swift
//  DeliveryApp
//
//  Created by abhisheksingh03 on 15/07/19.
//  Copyright © 2019 abhisheksingh03. All rights reserved.
//

import Foundation
import NotificationBannerSwift

// MARK: NotificationBanner
func showBannerWith(title: String? = nil, subtitle: String?, style: BannerStyle = BannerStyle.danger) {
    let banner = GrowingNotificationBanner(title: title, subtitle: subtitle, style: style)
    banner.show()
}
