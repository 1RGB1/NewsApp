//
//  NewsFeedTableViewCell.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 09/09/2021.
//

import UIKit
import Kingfisher

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var newsFeedImageView: UIImageView!
    @IBOutlet weak var newsFeedDescriptionLabel: UILabel!
    @IBOutlet weak var newsFeedSourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellContentView.setBorderColor(.black)
    }
}

extension NewsFeedTableViewCell: CellConfigurable {
    func setUp(model: BaseCellViewModel) {
        guard let viewModel = model as? NewsFeedCellViewModel else { return }
        
        let imageUrl = URL(string: viewModel.article.urlToImage ?? "")
        newsFeedImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(1))])
        newsFeedDescriptionLabel.text = viewModel.article.description ?? "N/A"
        newsFeedSourceLabel.text = viewModel.article.source?.name ?? "N/A"
    }
}
