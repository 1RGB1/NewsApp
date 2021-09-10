//
//  NewsFeedsStoreFailureMock.swift
//  NewsAppTests
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import Foundation
@testable import NewsApp

class NewsFeedsStoreFailureMock: NewsFeedStoreProtocol {
    func loadNewsFeedsPage(_ page: Int, bySearchQuery query: String, withCompletionBlock completion: @escaping (Result<ArticlesModel, NetworkError>) -> Void) {
        MockupHandler().getMockupModel(jsonFileName: "FailArticlesModel") { (model: ArticlesModel) in
            if let message = model.message {
                completion(.failure(NetworkError(errorMsg: message)))
            }
        }
    }
}
