//
//  Extension+UITextView.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 4/9/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit

// MARK: - Extension UITextView + Placehoulder
extension UITextView: UITextViewDelegate {
    
    private enum Keys {
        static let viewTagPlaceholder = 100
    }
    
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    // MARK: - init with code
    public convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        self.observerTextViewDidChange()
    }
    
    // MARK: - init with IB
    @IBInspectable public var placeholder: String? {
        get {
            var placeholderText: String?
            if let placeholderLabel = self.viewWithTag(Keys.viewTagPlaceholder) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            return placeholderText
        }
        set {
            observerTextViewDidChange()
            if let placeholderLabel = self.viewWithTag(Keys.viewTagPlaceholder) as? UILabel {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue)
            }
        }
    }
    
    private func observerTextViewDidChange() {
        self.delegate = self
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(Keys.viewTagPlaceholder) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
    }
    
    
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(Keys.viewTagPlaceholder) as? UILabel {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    private func addPlaceholder(_ placeholderText: String?) {
        guard let placeholderText = placeholderText else {
            return
        }
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        placeholderLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = Keys.viewTagPlaceholder
        placeholderLabel.isHidden = !self.text.isEmpty
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
    }
}

