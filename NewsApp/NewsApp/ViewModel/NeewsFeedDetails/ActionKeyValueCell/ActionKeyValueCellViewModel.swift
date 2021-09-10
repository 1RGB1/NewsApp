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
    let value: String?
    let url: URL?
    
    init(type: UITableViewCell.Type = ActionKeyValueTableViewCell.self, url: URL?, key: String, value: String?) {
        self.type = type
        self.url = url
        self.key = key
        self.value = value
    }
}
