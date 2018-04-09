//
//  Constants.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import SpriteKit
import UIKit

enum  KeyAccessToKen {
    static let key = "access_token"
}

// MARK: - Debug
let kDebug = false

// MARK: - Screen dimension convenience
let kViewSize = UIScreen.main.bounds.size
let kScreenCenter = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)
let kScreenCenterBottom = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.3)
let kScreenCenterTop = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.7)

// MARK: - Device size convenience
let kDeviceTablet = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)


enum GlobalConfig {
    static let dataVersion = 1
}
