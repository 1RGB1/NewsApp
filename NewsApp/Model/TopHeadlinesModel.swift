//
//  TopHeadlinesModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/8/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class TopHeadlinesModel: BaseModel {
    
    var totalResults: Int?
    var articles: [ArticleModel]?
    
    override func mapping(map: Map) {
        totalResults <- map["totalResults"]
        articles <- map["articles"]
    }
}
