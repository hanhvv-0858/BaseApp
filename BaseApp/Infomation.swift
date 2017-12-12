//
//  Infomation.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import Foundation

struct Infomation: Codable {
    var urlInfomation: String
    var originInfomation: String

    private enum CodingKeys: String, CodingKey {
        case urlInfomation = "url"
        case originInfomation = "origin"
    }
}
