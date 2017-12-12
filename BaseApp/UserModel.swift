//
//  User.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Foundation

struct User: ResponseObjectSerializable {
    var url: String?
    init?(response: HTTPURLResponse, representation: Any) {
        guard let representation = representation as? [String: Any], let url = representation["url"] as? String else {
            return nil
        }
        self.url = url
    }
    
    init() {
        
    }
    
    public func getUrl() -> String? {
        return url
    }
    
    public mutating func setUrl(_ url: String?) {
        self.url = url
    }
    
}
