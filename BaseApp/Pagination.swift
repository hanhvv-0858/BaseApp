//
//  Pagination.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 11/23/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import SwiftyJSON

class Pagination {
    
    var page: Int
    var perPage: Int
    var total: Int
    var totalPages: Int
    
    var isLoadMore: Bool {
        return page < totalPages
    }
    
    // MARK: - Init
    init() {
        self.page = 0
        self.perPage = 0
        self.total = 0
        self.totalPages = 0
    }
    
    convenience init?(jsonObject: Any?) {
        guard let jsonData = jsonObject else { return nil }
        self.init()
        
        // parse json
        let json = JSON(jsonData)
        self.parseJson(json)
    }
    
    convenience init?(json: JSON?) {
        guard let _json = json else { return nil }
        self.init()
        
        // parse json
        self.parseJson(_json)
    }
    
    private func parseJson(_ json: JSON) {

    }
}
