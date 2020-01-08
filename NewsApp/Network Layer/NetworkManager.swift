//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/8/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import Alamofire

class NetworkManager {
    
    // MARK: - Static fuunctions
    class func performNetworkActivityWithURL(_ url: String,
                                              Parameters params: [String : AnyHashable],
                                              HTTPMethod method: HTTPMethod,
                                              andCompletionHandler completion: @escaping(_ response: DataResponse<Any>) -> ()) {
        
        if let requestURL = URL(string: url) {
            Alamofire.request(requestURL, method: method, parameters: params).responseJSON { (response) in
                completion(response)
            }
        }
    }
}
