//
//  ResponseUIViewController.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 12/26/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

protocol ResponseUIViewController {
    
}

extension ResponseUIViewController where Self: UIViewController {
    static func fromNib() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
    
    static func fromStoryboard(_ storyboardName: UIStoryboard.StoryboardName, withIdentifier: String? = nil) -> Self {
        return Self.fromStoryboard(self, storyboardName: storyboardName, withIdentifier: withIdentifier)
    }
    
    fileprivate static func fromStoryboard<T: UIViewController>(_ type: T.Type, storyboardName: UIStoryboard.StoryboardName, withIdentifier: String?) -> T {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        let identifier = withIdentifier == nil ? type.name : withIdentifier!
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}

protocol ResponseUIView {

}

extension ResponseUIView where Self: UIView {
    
    static func fromNib<T: UIView>(_ type: T.Type) -> T {
            return Bundle.main.loadNibNamed(NSStringFromClass(type), owner: nil, options: nil)!.first as! T
        }
        
    static func fromNib() -> Self {
            return fromNib(self)
        }
}
