//
//  ActionKeyValueTableViewCell.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import UIKit

protocol ActionKeyValueTableViewCellDelegate: AnyObject {
    func didTapNavigateURL(_ url: URL)
}

class ActionKeyValueTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var viewModel: ActionKeyValueCellViewModel?
    weak var delegate: ActionKeyValueTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func navigateURLPressed(_ sender: Any) {
        guard let viewModel = viewModel,
              let url = viewModel.url
        else { return }
        delegate?.didTapNavigateURL(url)
    }
}

extension ActionKeyValueTableViewCell: CellConfigurable {
    func setUp(model: BaseCellViewModel) {
        guard let viewModel = model as? ActionKeyValueCellViewModel else { return }
        self.viewModel = viewModel
        
        keyLabel.text = viewModel.key
        valueLabel.text = viewModel.value
        actionButton.isHidden = (viewModel.url == nil)
    }
}
