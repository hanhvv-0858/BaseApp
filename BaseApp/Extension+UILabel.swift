//
//  Extension+UILabel.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 4/17/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit

extension UILabel {
    func contentSize() -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = self.lineBreakMode
        paragraphStyle.alignment = self.textAlignment
        let attributes: [String : AnyObject] = [NSFontAttributeName: self.font, NSParagraphStyleAttributeName: paragraphStyle]
        let contentSize: CGSize = self.text!.boundingRect(
            with: self.frame.size,
            options: ([.usesLineFragmentOrigin, .usesFontLeading]),
            attributes: attributes,
            context: nil
            ).size
        return contentSize
    }
    
    func setFrameWithString(_ string: String, width: CGFloat) {
        self.numberOfLines = 0
        let attributes: [String : AnyObject] = [
            NSFontAttributeName: self.font,
            ]
        let resultSize: CGSize = string.boundingRect(
            with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
            ).size
        let resultHeight: CGFloat = resultSize.height
        let resultWidth: CGFloat = resultSize.width
        var frame: CGRect = self.frame
        frame.size.height = resultHeight
        frame.size.width = resultWidth
        self.frame = frame
    }
}
