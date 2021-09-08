//
//  NetworkError.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 08/09/2021.
//

import Foundation

/// Base struct for network error
struct NetworkError: Error {
    
    /// Not the default network error message, it is defined when using it
    let errorMsg: String?
}
