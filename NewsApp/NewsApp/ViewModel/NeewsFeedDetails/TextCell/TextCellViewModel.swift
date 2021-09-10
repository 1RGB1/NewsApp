//
//  TextCellViewModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import Foundation
import UIKit

struct TextCellViewModel: BaseCellViewModel {
    
    var type: UITableViewCell.Type
    let text: String
    let font: UIFont
    
    init(type: UITableViewCell.Type = TextTableViewCell.self, text: String, font: UIFont = .systemFont(ofSize: 16)) {
        self.type = type
        self.text = text
        self.font = font
    }
}
