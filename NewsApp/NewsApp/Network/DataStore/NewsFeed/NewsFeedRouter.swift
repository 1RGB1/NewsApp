//
//  NewsFeedRouter.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 08/09/2021.
//

import Foundation
import Alamofire

enum NewsFeedRouter: ApiBaseRouter {
    case getNewsFeed(String, Int)
}

extension NewsFeedRouter {
    
    var path: String {
        return NetworkConstants.everythingPath
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getNewsFeed(let query, let page):
            return ["q" : query,
                    "page" : page,
                    "sortBy" : SortByType.publishedAt.rawValue,
                    "apiKey" : NetworkConstants.apiKey]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getNewsFeed:
            return .get
        }
    }
}
