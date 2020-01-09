//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/8/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import Foundation

protocol NewsListViewModelDelegate {
    func setTopHeadlinesList(_ model: TopHeadlinesModel?, _ error: String?)
    func setFilteredList(_ model: TopHeadlinesModel?, _ error: String?)
    func setSourcesList(_ model: SourcesModel?, _ error: String?)
}

class NewsListViewModel {
    
    // MARK: - Properties
    var newsStore = NewsStore()
    var delegate: NewsListViewModelDelegate!
    
    // MARK: - Functions
    func getTopHeadlinesListWithPage(_ page: Int) {
        
        let params: [String : AnyHashable] = ["apiKey" : API_KEY,
                                              "q" : "a",
                                              "page" : page]
        
        newsStore.getTopHeadlinesListWithParameters(params, headlinesType: .everything) { [weak self] (topHeadlinesModel, error) in
            if error == nil {
                self?.delegate.setTopHeadlinesList(topHeadlinesModel, nil)
            } else {
                self?.delegate.setTopHeadlinesList(nil, error)
            }
        }
    }
    
    func getFilteredHeadlinesByPage(_ page: Int, andFilterQuery filterQuery: FILTER_QUERY, andQuery query: String) {
        
        let filterBy = ((filterQuery == .source) ? "source" : "country")
        
        let params: [String : AnyHashable] = ["apiKey" : API_KEY,
                                              filterBy : query,
                                              "page" : page]
        
        newsStore.getTopHeadlinesListWithParameters(params, headlinesType: .filtered) { [weak self] (topHeadlinesModel, error) in
            if error == nil {
                self?.delegate.setTopHeadlinesList(topHeadlinesModel, nil)
            } else {
                self?.delegate.setTopHeadlinesList(nil, error)
            }
        }
    }
    
    func getSources() {
        
        let params: [String : AnyHashable] = ["apiKey" : API_KEY]
        
        newsStore.getSourcesWithParameters(params) { [weak self] (sourcesModel, error) in
            if error == nil {
                self?.delegate.setSourcesList(sourcesModel, nil)
            } else {
                self?.delegate.setSourcesList(nil, error)
            }
        }
    }
}
