//
//  ImageTextCellViewModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import Foundation
import UIKit

struct ImageTextCellViewModel: BaseCellViewModel {
    
    var type: UITableViewCell.Type
    let imageUrl: URL?
    let text: String
    
    init(type: UITableViewCell.Type = ImageTextTableViewCell.self, imageUrl: URL?, text: String = "") {
        self.type = type
        self.imageUrl = imageUrl
        self.text = text
    }
}
