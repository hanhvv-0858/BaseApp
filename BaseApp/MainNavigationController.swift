//
//  MainNavigationController.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/11/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    var playerView = VideoPlayerView(frame: .zero)
    var setingsView = SettingsView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
