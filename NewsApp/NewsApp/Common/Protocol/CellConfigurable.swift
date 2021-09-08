//
//  CellConfigurable.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 09/09/2021.
//

import Foundation

/// A type that handles cell's view model.
protocol CellConfigurable {
    
    /// To setup cell with its view model
    /// - Parameters:
    ///   - model:   cell's view model
    func setUp<T: BaseCellViewModel>(model: T)
}
