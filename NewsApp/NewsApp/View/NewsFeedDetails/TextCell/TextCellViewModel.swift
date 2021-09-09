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
    let fontSize: CGFloat
}
