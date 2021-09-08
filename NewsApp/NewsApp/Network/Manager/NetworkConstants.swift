//
//  NetworkConstants.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 08/09/2021.
//

import Alamofire

struct NetworkConstants {
    
    /// API's base url
    static let baseUrl = "https://newsapi.org/v2/"
    
    /// API's path for every news feeds
    static let everythingPath = "everything"
    
    /// API's key
    static let apiKey = "c1857823daa84c6fa5ff3974a21ce78b"
    
    /// Generic error message
    static let genericError = "Something went wrong"
}

/// API's sort by keys 
enum SortByType: String {
    case relevancy = "relevancy"
    case popularity = "popularity"
    case publishedAt = "publishedAt"
}
