//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 08/09/2021.
//

import Foundation
import Alamofire

/// Singletone manager to handle all api calls
struct NetworkManager {
    
    private init() {}
    
    static let shared: NetworkManager = {
        let instance = NetworkManager()
        return instance
    } ()
    
    /// To load data from api in a generic way
    /// - Parameters:
    ///   - request:    request conforming base router combined with all required attributes for calling the api
    ///   - completion: completion block with model or with the network error
    func getData<T: BaseModel>(request: URLRequestConvertible, completion: @escaping (Result<T, NetworkError>) -> Void) {
        AF.request(request).responseData(completionHandler: { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch let errorModel {
                    let error = NetworkError(errorMsg: errorModel.localizedDescription)
                    completion(.failure(error))
                }
            case .failure:
                let error = NetworkError(errorMsg: NetworkConstants.genericError)
                completion(.failure(error))
            }
        })
    }
}
