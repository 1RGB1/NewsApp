//
//  NewsFeedsViewModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 09/09/2021.
//

import Foundation

class NewsFeedViewModel {
    
    var cellsViewModels = [BaseCellViewModel]()
    private var newsFeedStore = NewsFeedStore()
    var currentPage = 1
    var query = "apple"
    
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
        
        let articlesViewModels = articles.map { (articleModel) -> NewsFeedTableViewCellViewModel in
            let url = URL(string: articleModel.urlToImage ?? "")
            let source = articleModel.source?.name ?? ""
            return NewsFeedTableViewCellViewModel(type: NewsFeedTableViewCell.self, imageUrl: url, description: articleModel.description, source: source)
        }
        
        cellsViewModels.append(contentsOf: articlesViewModels)
    }
}
