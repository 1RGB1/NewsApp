//
//  NewsFeedStore.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 08/09/2021.
//

import Foundation

class NewsFeedStore {
    
    /// To load news feeds
    /// - Parameters:
    ///   - page:       for pagination feature to load page by page
    ///   - query:      search query to find all news related to it
    ///   - completion: completion block with model or with the network error
    func loadNewsFeedsPage(_ page: Int,
                           bySearchQuery query: String,
                           withCompletionBlock completion: @escaping (Result<ArticlesModel, NetworkError>) -> Void) {
    
        let newsFeedRouter = NewsFeedRouter.getNewsFeed(query, page)
        
        NetworkManager.shared.getData(request: newsFeedRouter) { (result: Result<ArticlesModel, NetworkError>) in
            completion(result)
        }
    }
}
