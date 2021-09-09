//
//  ActionKeyValueCellViewModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import Foundation
import UIKit

struct ActionKeyValueCellViewModel: BaseCellViewModel {
    var type: UITableViewCell.Type
    let key: String
    let value: String
    let url: URL?
}
