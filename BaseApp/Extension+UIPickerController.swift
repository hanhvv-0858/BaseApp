//
//  CustomUIPickerController.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

public typealias FinishPickingMediaClosure = (UIImagePickerController, UIImage?) -> Void
public typealias CancelClosure = (UIImagePickerController) -> Void

private var associatedEventHandle: UInt8 = 0
extension UIImagePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var closuresWrapper: ClosuresWrapper {
        get {
            if let wrapper = objc_getAssociatedObject(self, &associatedEventHandle) as? ClosuresWrapper {
                return wrapper
            }
            let closuresWrapper = ClosuresWrapper()
            self.closuresWrapper = closuresWrapper
            return closuresWrapper
        }
        set {
            self.delegate = self
            objc_setAssociatedObject(self, &associatedEventHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - KVO
    public var didFinishPickingMedia: FinishPickingMediaClosure? {
        set { self.closuresWrapper.didFinishPickingMedia = newValue }
        get { return self.closuresWrapper.didFinishPickingMedia }
    }
    
    public var didCancel: CancelClosure? {
        set { self.closuresWrapper.didCancel = newValue }
        get { return self.closuresWrapper.didCancel }
    }
    
    // MARK: - UIImagePickerControllerDelegate implementation
    open func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.closuresWrapper.didFinishPickingMedia?(picker, info["UIImagePickerControllerOriginalImage"] as? UIImage)
    }
    
    open func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.closuresWrapper.didCancel?(picker)
    }
}

fileprivate final class ClosuresWrapper {
    fileprivate var didFinishPickingMedia: FinishPickingMediaClosure?
    fileprivate var didCancel: CancelClosure?
}
