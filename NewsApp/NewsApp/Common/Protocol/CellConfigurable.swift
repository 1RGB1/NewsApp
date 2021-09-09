//
//  CellConfigurable.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 09/09/2021.
//

import Foundation
import UIKit

/// A type that handles cell's view model.
protocol CellConfigurable: UITableViewCell {
    
    /// To setup cell with its view model
    /// - Parameters:
    ///   - model:   cell's view model
    func setUp(model: BaseCellViewModel)
}
