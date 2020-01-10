//
//  HeadlineTableViewCell.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/9/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import UIKit
import Kingfisher

class HeadlineTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headlineLogoImageView: UIImageView!
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var headlineDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.setCornerByValue(cornerRadius: true, value: 40)
        containerView.addShadow(color: UIColor.black, opacity: 0.3, radius: 2)
    }
    
    func setModel(_ model: ArticleModel?) {
        if let article = model {
            
            let imageURL = article.urlToImage ?? ""
            Utilities.setImage(headlineLogoImageView, imageURL)
            
            headlineTitleLabel.text = article.title ?? "Headline"
            
            headlineDateLabel.text = (article.publishedAt ?? "").convertDateString() ?? ""
        }
    }
}
