//
//  LoadingJSON.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Foundation
import SwiftyJSON

func loadJSON(forResource: String, ofType: String, _ completionHandler: @escaping(JSON) -> Void) {
    if let path = Bundle.main.path(forResource: forResource, ofType: ofType) {
        if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
            let json = JSON(dict)
            completionHandler(json)
        }
    }
}

func loadFilePlist(forResource: String, ofType: String, _ completionHandler: @escaping([String: Any]) -> Void) {
    if let path = Bundle.main.path(forResource: forResource, ofType: ofType) {
        if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
            completionHandler(dict)
        }
    }
}
