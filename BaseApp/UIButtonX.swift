//
//  UIButtonX.swift
//  DesignableX_IB
//
//  Created by Phong Nguyen on 7/14/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

@IBDesignable
class UIButtonX: UIButton {
    
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .blue {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    //Gradient
    
    @IBInspectable
    var enableGradientBackground: Bool = false
    
    @IBInspectable
    var gradientColor1: UIColor = .black
    @IBInspectable
    var gradientColor2: UIColor = .white
    
    //Title
    
    @IBInspectable
    var titleLeftPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.left = titleLeftPadding
        }
    }
    @IBInspectable
    var titleRightPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.right = titleRightPadding
        }
    }
    @IBInspectable
    var titleTopPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.top = titleTopPadding
        }
    }
    
    @IBInspectable
    var titleBottomPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.bottom = titleBottomPadding
        }
    }
    
    //Image
    
    @IBInspectable
    var imageLeftPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.left = imageLeftPadding
        }
    }
    @IBInspectable
    var imageRightPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.right = imageRightPadding
        }
    }
    @IBInspectable
    var imageTopPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.top = imageTopPadding
        }
    }
    
    @IBInspectable
    var imageBottomPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.bottom = imageBottomPadding
        }
    }
}
