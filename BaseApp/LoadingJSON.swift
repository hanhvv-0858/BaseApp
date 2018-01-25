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
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let json = JSON(data)
            completionHandler(json)
            
        } catch {
            logD(nil)
        }
    }
}

func loadFilePlist(forResource: String, ofType: String, _ completionHandler: @escaping(NSDictionary) -> Void) {
    if let path = Bundle.main.path(forResource: forResource, ofType: ofType) {
        if let dict = NSDictionary(contentsOfFile: path) {
            completionHandler(dict)
        }
    }
}
