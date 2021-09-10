//
//  ImageTextTableViewCell.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import UIKit
import Kingfisher

class ImageTextTableViewCell: UITableViewCell {

    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var viewContaningLabel: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension ImageTextTableViewCell: CellConfigurable {
    func setUp(model: BaseCellViewModel) {
        guard let viewModel = model as? ImageTextCellViewModel else { return }
        
        contentImage.kf.setImage(with: viewModel.imageUrl, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(1))])
        
        if viewModel.text != "" {
            contentLabel.text = viewModel.text
        } else {
            viewContaningLabel.isHidden = true
        }
    }
}
