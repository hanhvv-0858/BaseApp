//
//  ResponseType.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/17/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit

protocol ResponseType {
    
}

extension ResponseType {
    
    static var type: Self.Type {
        return Self.self
    }
    
    var type: Self.Type {
        return Self.self
    }
}
