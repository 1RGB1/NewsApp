//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 08/09/2021.
//

import Foundation

struct ArticleModel: Codable {
    let source: SourceModel?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String? // ex: "2021-09-08T19:15:05Z"
    let content: String?
}
