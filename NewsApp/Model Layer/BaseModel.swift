//
//  BaseModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/8/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class BaseModel: Mappable {
    
    var status: String?
    var message: String?
    var code: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        code <- map["code"]
    }
}
