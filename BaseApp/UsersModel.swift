//
//  Users.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Foundation
import SwiftyJSON

final class Users: ResponseObjectSerializable, ResponseCollectionSerializable {
    
    /// Private Property
    fileprivate var username: String?
    fileprivate var name: String?
    
    init?() {
    }

    // MARK: - init
    init?(response: HTTPURLResponse, representation: Any) {
        let json = JSON(representation)
        parseJSON(json)
    }
    
    convenience init?(_ json: JSON?) {
        self.init()
        guard let json = json else {
            return nil
        }
        parseJSON(json)
    }
    
    convenience init?(_ data: Any?) {
        self.init()
        guard let data = data else {
            return nil
        }
        parseJSON(JSON(data))
    }
}

extension Users: ResponseModel {
    
}

extension Users {
    
    /// all init call to here -> pass data
    fileprivate func parseJSON(_ json: JSON) {
        self.username = json[JSONKey.userName].string
        self.name = json[JSONKey.name].string
    }
    
    /// Getter and Setter Property
    public func setName(_ name: String?) {
        self.name = name
    }
    
    public func setUserName(_ username: String?) {
        self.username = username
    }
    
    public func getName() -> String? {
        return name
    }
    public func getUserName() -> String? {
        return username
    }
}
