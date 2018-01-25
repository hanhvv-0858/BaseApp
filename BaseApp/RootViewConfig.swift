//
//  RootViewConfig.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit
class RootViewConfig {
    
    // MARK: Singletion
    static let sharedInstance = RootViewConfig()
    private init() {
    }
    
    func config( window: UIWindow?) {
        let vc = MainNavigationController.fromStoryboard(.mainApp)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
