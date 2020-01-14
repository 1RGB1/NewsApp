//
//  FilterPopupViewModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/14/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import Foundation

protocol FilterPopupViewModelDelegate {
    func setCountriesList(_ countries: [String]?, _ error: String?)
    func setSourcesList(_ model: SourcesModel?, _ error: String?)
}

class FilterPopupViewModel {
    
    // MARK: - Properties
    var newsStore = NewsStore()
    var delegate: FilterPopupViewModelDelegate!
    
    // MARK: - Functions
    func getCountriesList() {
        
        newsStore.getCountriesWithCompletion { [weak self] (countries, error) in
            if error == nil {
                self?.delegate.setCountriesList(countries, nil)
            } else {
                self?.delegate.setCountriesList(nil, error)
            }
        }
    }
    
    func getSourcesList() {
        
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
