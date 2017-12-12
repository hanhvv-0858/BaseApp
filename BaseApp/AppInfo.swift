//
//  AppInfo.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Foundation

struct AppInfo {
    static let version: String? = Bundle.main.infoDictionary?["BaseApp"] as? String
    static let build: String? = Bundle.main.infoDictionary?["BaseApp"] as? String
}
