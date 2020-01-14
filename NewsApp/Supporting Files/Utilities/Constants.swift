//
//  Constants.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/8/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import Alamofire

// UI Manipulations
let SHADOW_GREY: CGFloat = 120 / 255.0

// HTPP Methods
let GET: HTTPMethod = HTTPMethod.get
let POST: HTTPMethod = HTTPMethod.post
let PUT: HTTPMethod = HTTPMethod.put

// API Key
let API_KEY: String = "267ceaf325a9437eae27a460b05d5484"

// Other URL Configurations
let ENGLISH: String = "en-US"
let ERROR_Message: String = "error"

// Calling APIs
let BASE_URL: String = "https://newsapi.org/v2/"
let TOP_HEADLINES: String = "top-headlines"
let SOURCES: String = "sources"

let NEWS_LIST_URL: String = BASE_URL + TOP_HEADLINES
let SOURCES_URL: String = BASE_URL + SOURCES
let COUNTRIES_UR: String = BASE_URL + ""

let FILTER_URL: String = BASE_URL + TOP_HEADLINES

enum FilterQuery {
    case country
    case source
}

enum Headlines {
    case everything
    case filtered
}
