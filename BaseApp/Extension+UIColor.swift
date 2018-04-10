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
        return UIColor(r: red, g: green, b: blue)
    }
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
