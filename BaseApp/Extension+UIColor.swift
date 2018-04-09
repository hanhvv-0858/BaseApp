//
//  Extension+UIColor.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/24/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
