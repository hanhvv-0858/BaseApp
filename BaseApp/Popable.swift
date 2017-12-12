//
//  Buzzable.swift
//  iOSTraining82017
//
//  Created by Phong Nguyen on 8/15/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol Popable {

}

extension Popable where Self: UIView {
    func pop() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {self.alpha = 1}, completion: {_ in
            UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseIn, animations: {self.alpha = 0}, completion: nil)
        })
    }
    
    func popBuzz() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {self.alpha = 1}, completion: {_ in
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.05
                animation.repeatCount = 5
                animation.autoreverses = true
                animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
                animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
                self.layer.add(animation, forKey: "position")
                UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseIn, animations: {self.alpha = 0}, completion: nil)
            })
        }
    }
}
