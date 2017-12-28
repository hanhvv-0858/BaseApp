//
//  CollectionViewSmart.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 1/4/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit


// MARK: - CollectionView
class UICollectionViewSmart: UICollectionView, UITextViewDelegate {
    
    override var contentSize: CGSize {
        willSet(newValue) {
            if newValue.equalTo(self.contentSize) {
                return
            }
            super.contentSize = newValue
            TPKeyboardAvoiding_updateContentInset()
        }
    }
    
    
    override var frame:CGRect{
        willSet{
            super.frame = frame
        }
        
        didSet {
            TPKeyboardAvoiding_updateContentInset()
        }
    }
    
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        self.setup()
        
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func focusNextTextField() -> Bool {
        return self.TPKeyboardAvoiding_focusNextTextField()
    }
    
    func scrollToActiveTextField() {
        return self.TPKeyboardAvoiding_scrollToActiveTextField()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView(_:)), object: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.TPKeyboardAvoiding_findFirstResponderBeneathView(self)?.resignFirstResponder()
        super.touchesEnded(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !self.focusNextTextField() {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView(_:)), object: self)
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView(_:)), userInfo: nil, repeats: false)
    }
}

private extension UICollectionViewSmart {
    func setup() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(TPKeyboardAvoiding_keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(TPKeyboardAvoiding_keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: NSNotification.Name.UITextViewTextDidBeginEditing,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: NSNotification.Name.UITextFieldTextDidBeginEditing,
                                               object: nil)
    }
}
