//
//  SwipeGustureRecognizer.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 12/28/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

enum PanDirection: Int {
    case right
    case down
    case left
    case up
}

class SwipeGestureRecognizer: UIPanGestureRecognizer {
    var direction: PanDirection?
    var isDragging = false
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        if state == .failed {
            return
        }
        
        let velocity: CGPoint = self.velocity(in: view)
        if !isDragging && !velocity.equalTo(.zero) {
            let velocities = [PanDirection.right: velocity.x, PanDirection.down: velocity.y, PanDirection.left: -velocity.x, PanDirection.up: -velocity.y]
            let keysSorted = velocities.sorted{$0.value < $1.value}.last?.key.hashValue
            if keysSorted != self.direction?.hashValue {
                self.state = .failed
            }
            self.isDragging = true
        }
    }
    
    override func reset() {
        super.reset()
        isDragging = false
    }
}
