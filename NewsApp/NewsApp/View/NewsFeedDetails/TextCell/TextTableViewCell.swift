//
//  TextTableViewCell.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension TextTableViewCell: CellConfigurable {
    func setUp(model: BaseCellViewModel) {
        guard let viewModel = model as? TextCellViewModel else { return }
        contentLabel.text = viewModel.text
        contentLabel.font = UIFont(name: contentLabel.font.fontName, size: viewModel.fontSize)
    }
}
