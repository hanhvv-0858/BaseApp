//
//  ResponseModel.swift
//  BaseApp
//
//  Created by Phong Nguyen on 12/13/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import SwiftyJSON

protocol ResponseModel {
    init?(_ json: JSON?)
}

extension ResponseModel {
    
    static func responseObject(forKey: String? = nil, object: Any?) -> Self? {
        guard let object = object else {
            return nil
        }
        
        /// has key
        if let _forkey = forKey {
            let json = JSON(object)[_forkey]
            return self.init(json)
        }
        
        /// not key
        let json = JSON(object)
        return self.init(json)
    }
    
    static func responseCollectionObject(forKey: String? = nil, object: Any?) -> [Self]? {
        guard let object = object else {
            return nil
        }
        
        /// has key
        if let _forKey = forKey {
            let jsons = JSON(object)[_forKey].arrayValue
            return jsons.flatMap{self.init($0)}
        }
        
        /// not key
        let jsons = JSON(object).arrayValue
        return jsons.flatMap{self.init($0)}
    }
}
