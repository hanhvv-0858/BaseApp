//
//  ConfigApp.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Foundation

final class ConfigApp {
    
    static let sharedInstance = ConfigApp()
    private init() {
    
    }

    func addToken(token: String?) {
        logD(token)
        guard let token = token else {
            return
        }
        UserDefaults.standard.setValue(token, forKey: KeyAccessToKen.key)
    }
    
    func removeToken(key: String) {
        UserDefaults.standard.removeObject(forKey: KeyAccessToKen.key)
    }
}
