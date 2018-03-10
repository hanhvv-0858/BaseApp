//
//  Colors.swift
//  BaseApp
//
//  Created by Phong Nguyen on 3/10/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import Foundation


import SpriteKit

class Colors {
    
    func colorFrom(rgbValue: Int) -> SKColor {
        return SKColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1.0)
    }
}
