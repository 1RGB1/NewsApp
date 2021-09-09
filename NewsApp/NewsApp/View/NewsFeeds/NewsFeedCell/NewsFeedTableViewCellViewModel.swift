//
//  NewsFeedTableViewCellViewModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 09/09/2021.
//

import Foundation
import UIKit

struct NewsFeedTableViewCellViewModel: BaseCellViewModel {
    var type: UITableViewCell.Type
    var imageUrl: URL?
    var description: String?
    var source: String?
}
