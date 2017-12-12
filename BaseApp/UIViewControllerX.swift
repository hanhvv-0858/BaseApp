//
//  UIViewControllerX.swift
//  DesignableX_IB
//
//  Created by Phong Nguyen on 7/14/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

@IBDesignable
class UIViewCOntrollerX: UIViewController {
    
    @IBInspectable var lightStatusBar: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            if lightStatusBar {
                return .lightContent
            } else {
                return .default
            }
        }
    }
}
