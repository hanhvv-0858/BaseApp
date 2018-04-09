//
//  Extension+UIFont.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/24/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//
import UIKit

// MARK: - Properties
public extension UIFont {

    public var bold: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }

    public var italic: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0)
    }
}

