//
//  AppInfo.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Foundation

struct AppInfo {
    static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    static let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    static let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
}
