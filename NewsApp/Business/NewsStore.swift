//
//  NewsStore.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/8/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class NewsStore: BaseNetwork {
    
    func getTopHeadlinesListWithParameters(_ params: [String : AnyHashable], headlinesType: HEADLINES, andCompletionHandler completion: @escaping (_ model: TopHeadlinesModel?, _ error: String?) -> ()) {
        
        let url = ((headlinesType == .everything) ? NEWS_LIST_URL : FILTER_URL)
        
        NetworkManager.performNetworkActivityWithURL(url, Parameters: params, HTTPMethod: GET) { (response) in
            
            guard let responseValue = response.result.value else {
                completion(nil, self.handleError(999))
                return
            }
            
            if let topHeadlinesModel = Mapper<TopHeadlinesModel>().map(JSONObject: responseValue) {
                if topHeadlinesModel.status == ERROR_Message {
                    completion(nil, topHeadlinesModel.message)
                } else {
                    completion(topHeadlinesModel, nil)
                }
            }
        }
    }
    
    func getSourcesWithParameters(_ params: [String : AnyHashable], andCompletionHandler completion: @escaping (_ model: SourcesModel?, _ error: String?) -> ()) {
        
        NetworkManager.performNetworkActivityWithURL(SOURCES_URL, Parameters: params, HTTPMethod: GET) { (response) in
            
            guard let responseValue = response.result.value else {
                completion(nil, self.handleError(999))
                return
            }
            
            if let sourcesModel = Mapper<SourcesModel>().map(JSONObject: responseValue) {
                if sourcesModel.status == ERROR_Message {
                    completion(nil, sourcesModel.message)
                } else {
                    completion(sourcesModel, nil)
                }
            }
        }
    }
}
