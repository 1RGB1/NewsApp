//
//  NewsStore.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/8/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import ObjectMapper
import FirebasePerformance

class NewsStore: BaseNetwork {
    
    func getTopHeadlinesListWithParameters(_ params: [String : AnyHashable], headlinesType: Headlines, andCompletionHandler completion: @escaping (_ model: TopHeadlinesModel?, _ error: String?) -> ()) {
        
        let url = ((headlinesType == .everything) ? NEWS_LIST_URL : FILTER_URL)
        
        let trace = Performance.startTrace(name: "top_headlines_request_trace")
        guard let targetUrl = URL(string: url) else { return }
        guard let metric = HTTPMetric(url: targetUrl, httpMethod: .get) else { return }
        
        metric.start()
        
        NetworkManager.performNetworkActivityWithURL(url, Parameters: params, HTTPMethod: GET) { (response) in
            
            trace?.incrementMetric("top_headlines_request_sent", by: 1)
            
            guard let responseValue = response.result.value else {
                trace?.stop()
                metric.stop()
                
                completion(nil, self.handleError(999))
                return
            }
            
            if let topHeadlinesModel = Mapper<TopHeadlinesModel>().map(JSONObject: responseValue) {
                metric.stop()
                trace?.stop()
                
                if topHeadlinesModel.status == ERROR_Message {
                    completion(nil, topHeadlinesModel.message)
                } else {
                    completion(topHeadlinesModel, nil)
                }
            }
        }
    }
    
    func getCountriesWithCompletion(_ completion: @escaping (_ model: [String]?, _ error: String?) -> ()) {
        var countries: [String]?
        
        let trace = Performance.startTrace(name: "read_countries_from_file_trace")
        
        if  let path = Bundle.main.path(forResource: "Countries", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path) {
            
            do {
                countries = try PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? [String]
                trace?.stop()
                completion(countries, nil)
            } catch {
                trace?.stop()
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func getSourcesWithParameters(_ params: [String : AnyHashable], andCompletionHandler completion: @escaping (_ model: SourcesModel?, _ error: String?) -> ()) {
        
        let trace = Performance.startTrace(name: "sources_request_trace")
        guard let targetUrl = URL(string: SOURCES_URL) else { return }
        guard let metric = HTTPMetric(url: targetUrl, httpMethod: .get) else { return }
        
        metric.start()
        
        NetworkManager.performNetworkActivityWithURL(SOURCES_URL, Parameters: params, HTTPMethod: GET) { (response) in
            
            trace?.incrementMetric("sources_request_sent", by: 1)
            
            guard let responseValue = response.result.value else {
                trace?.stop()
                metric.stop()
                
                completion(nil, self.handleError(999))
                return
            }
            
            if let sourcesModel = Mapper<SourcesModel>().map(JSONObject: responseValue) {
                trace?.stop()
                metric.stop()
                
                if sourcesModel.status == ERROR_Message {
                    completion(nil, sourcesModel.message)
                } else {
                    completion(sourcesModel, nil)
                }
            }
        }
    }
}
