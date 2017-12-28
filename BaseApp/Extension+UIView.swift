//
//  Extension+UIView.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit


extension UIView {
    func addLeftSideShadowWithFading() {
        let shadowWidth: CGFloat = 4.0
        let shadowVerticalPadding: CGFloat = -20.0
        
        let shadowHeight: CGFloat = frame.height - 2 * shadowVerticalPadding
        let shadowRect = CGRect(x: -shadowWidth, y: shadowVerticalPadding, width: shadowWidth, height: shadowHeight)
        let shadowPath = UIBezierPath(rect: shadowRect)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = 0.2
        
        let toValue: CGFloat = 0.0
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = layer.shadowOpacity
        animation.toValue = toValue
        layer.add(animation, forKey: nil)
        layer.shadowOpacity = Float(toValue)
    }
}

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
