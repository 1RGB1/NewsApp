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

// Calling APIs
let BASE_URL: String = "https://newsapi.org/v2/"
let TOP_HEADLINES_URL_EXTENSION: String = "top-headlines?"
let IMAGE_BASE_URL: String = ""

let NEWS_LIST_URL_EXTENSION: String = BASE_URL + TOP_HEADLINES_URL_EXTENSION + "q=a&" + "apiKey=\(API_KEY)" + "&page="
let COUNTRIES_URL_EXTENSION: String = BASE_URL + ""
let SOURCES_URL_EXTENSION: String = BASE_URL + "sources?" + "apiKey=\(API_KEY)"

let FILTER_URL_EXTENSION: String = BASE_URL + TOP_HEADLINES_URL_EXTENSION + "apiKey=\(API_KEY)" + "&country="
let COUNTRY_URL_EXTENSION: String = BASE_URL + TOP_HEADLINES_URL_EXTENSION + "apiKey=\(API_KEY)" + "&sources="
