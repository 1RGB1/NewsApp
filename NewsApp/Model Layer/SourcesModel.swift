//
//  SourcesModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/8/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class SourcesModel: BaseModel {
    
    var sources: [SourceModel]?
    
    override func mapping(map: Map) {
        sources <- map["sources"]
    }
}
