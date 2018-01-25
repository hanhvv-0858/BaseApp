//
//  Extension+UIStoryboard.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 25/01/2018.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum StoryboardName: String {
        case main = "Main"
        case mainApp = "MainApp"
        case loginRegister = "LoginRegister"
    }
    
    convenience init(storyboard: StoryboardName, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    class func storyboard(_ storyboard: StoryboardName, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.name) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.name) ")
        }
        
        return viewController
    }
}
