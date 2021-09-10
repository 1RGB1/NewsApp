//
//  NewsFeedsStoreSuccessfullMock.swift
//  NewsAppTests
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import Foundation
@testable import NewsApp

class NewsFeedsStoreSuccessfullMock: NewsFeedStoreProtocol {
    func loadNewsFeedsPage(_ page: Int, bySearchQuery query: String, withCompletionBlock completion: @escaping (Result<ArticlesModel, NetworkError>) -> Void) {
        MockupHandler().getMockupModel(jsonFileName: "SuccessArticlesModel") { (model: ArticlesModel) in
            completion(.success(model))
        }
    }
}
