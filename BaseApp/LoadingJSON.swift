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
    if let file = Bundle.main.path(forResource: forResource, ofType: ofType) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file))
            let json = JSON(data)
            completionHandler(json)
            
        } catch {
            logD(nil)
        }
    }
}
