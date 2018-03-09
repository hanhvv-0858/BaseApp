//
//  Block.swift
//  BaseApp
//
//  Created by Phong Nguyen on 3/9/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit


public protocol Block {}

extension Block where Self: Any {
    
    /// Structures and Enumerations **Are Value Types**
    public func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
    
    /// To do Something
    public func `do`(_ block: (inout Self) throws -> Void) rethrows {
        var copy = self
        try block(&copy)
    }
}

extension Block where Self: AnyObject {
    /// Classes Are Reference Types
    public func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Block {}
extension CGSize: Block {}
