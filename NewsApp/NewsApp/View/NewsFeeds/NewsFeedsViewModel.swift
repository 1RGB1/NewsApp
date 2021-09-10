//
//  NewsFeedsViewModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 09/09/2021.
//

import Foundation

class NewsFeedViewModel {
    
    var cellsViewModels = [BaseCellViewModel]()
    private var newsFeedStore: NewsFeedStoreProtocol
    var currentPage = 1
    var query = "apple"
    
    init(newsFeedStore: NewsFeedStoreProtocol = NewsFeedStore()) {
        self.newsFeedStore = newsFeedStore
    }
    
    func loadNewsFeedsPage(withSuccessBlock success: @escaping () -> Void,
                           withFailureBlock fail: @escaping (String) -> Void) {
        newsFeedStore.loadNewsFeedsPage(currentPage, bySearchQuery: query) { [weak self] (result: Result<ArticlesModel, NetworkError>) in

            guard let self = self else { return }

            switch result {
            case .success(let model):
                self.prepCellsViewModelsWithArticles(model)
                success()
            case .failure(let error):
                fail(error.errorMsg)
            }
        }
    }
    
    fileprivate func prepCellsViewModelsWithArticles(_ articlesModel: ArticlesModel) {
        if currentPage == 1 {
            cellsViewModels.removeAll()
        }
        
        guard let articles = articlesModel.articles else { return }
        
        let articlesViewModels = articles.map {
            NewsFeedCellViewModel(article: $0)
        }
        
        cellsViewModels.append(contentsOf: articlesViewModels)
    }
}
