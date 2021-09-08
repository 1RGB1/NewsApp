//
//  ArticlesModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 08/09/2021.
//

import Foundation

struct ArticlesModel: BaseModel, Codable {
    var status: String?
    var code: String?
    var message: String?
    var totalResults: Int?
    var articles: [ArticleModel]?
}
