//
//  KeyValueTableViewCell.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import UIKit

class KeyValueTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension KeyValueTableViewCell: CellConfigurable {
    func setUp(model: BaseCellViewModel) {
        guard let viewModel = model as? KeyValueCellViewModel else { return }
        keyLabel.text = viewModel.key
        valueLabel.text = viewModel.value ?? "N/A"
    }
}
