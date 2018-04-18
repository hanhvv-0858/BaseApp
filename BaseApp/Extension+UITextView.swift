//
//  Extension+UITextView.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 4/9/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit

// MARK: - Extension UITextView + Placehoulder
public typealias TextViewClosure = (String?) -> Void
fileprivate var addressKeyLimitCharacter = 1
fileprivate var closureAdapter = 2
fileprivate var addressColorPlaceholder = 101

fileprivate final class ClosuresWrapper {
    fileprivate var didFinishPickingMedia: TextViewClosure?
}

extension UITextView: UITextViewDelegate {

    fileprivate var closuresWrapper: ClosuresWrapper {
        get {
            if let wrapper = objc_getAssociatedObject(self, &closureAdapter) as? ClosuresWrapper {
                return wrapper
            }
            let closuresWrapper = ClosuresWrapper()
            self.closuresWrapper = closuresWrapper
            return closuresWrapper
        }
        set {
            self.delegate = self
            objc_setAssociatedObject(self, &closureAdapter, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    
    public var limitCharacter: Int? {
        get {
            if let number = objc_getAssociatedObject(self, &addressKeyLimitCharacter) as? Int {
                return number
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &addressKeyLimitCharacter, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var textViewClosure: TextViewClosure? {
        get { return closuresWrapper.didFinishPickingMedia }
        set { closuresWrapper.didFinishPickingMedia = newValue }
    }

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
            if let placeholderLabel = self.viewWithTag(Keys.viewTagPlaceholder) as? UILabel {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue)
            }
        }
    }
    
    @IBInspectable public var placeholderColor: UIColor? {
        get {
            if let wrapper = objc_getAssociatedObject(self, &addressColorPlaceholder) as? UIColor {
                return wrapper
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &addressColorPlaceholder, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(Keys.viewTagPlaceholder) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
            textViewClosure?(textView.text)
        }
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        guard let limitCharacter = limitCharacter else {
            return true // not limit
        }
        return updatedText.count <= limitCharacter // Change limit based on your requirement.
    }


    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(Keys.viewTagPlaceholder) as? UILabel {
            placeholderLabel.lineBreakMode = .byWordWrapping
            placeholderLabel.numberOfLines = 0
            placeholderLabel.adjustsFontSizeToFitWidth = true
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.sizeThatFits(CGSize(width: labelWidth, height: self.frame.size.height)).height
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }

    private func addPlaceholder(_ placeholderText: String?) {
        guard let placeholderText = placeholderText else {
            return
        }
        self.delegate = self
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholderText
        placeholderLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        placeholderLabel.textColor = placeholderColor ?? UIColor.lightGray
        placeholderLabel.tag = Keys.viewTagPlaceholder
        placeholderLabel.isHidden = !self.text.isEmpty
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
    }


}


