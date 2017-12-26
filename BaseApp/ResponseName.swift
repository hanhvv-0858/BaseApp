//
//  ResponseName.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 12/25/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Foundation

protocol ResponseName {
}

extension ResponseName {
    var name: String {
        return String(describing: type(of: self))
    }
    
    static var name: String {
        return String(describing: self)
    }
}

protocol ResponseIdentifier {
}

extension ResponseIdentifier {
    var identifier: String {
        return String(describing: type(of: self))
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
