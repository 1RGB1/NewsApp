//
//  NewsFeedCellViewModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 09/09/2021.
//

import Foundation
import UIKit

struct NewsFeedCellViewModel: BaseCellViewModel {
    
    var type: UITableViewCell.Type
    var article: ArticleModel
    
    init(type: UITableViewCell.Type = NewsFeedTableViewCell.self, article: ArticleModel) {
        self.type = type
        self.article = article
    }
}
