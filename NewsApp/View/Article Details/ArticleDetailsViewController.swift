//
//  ArticleDetailsViewController.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 1/9/20.
//  Copyright © 2020 Ahmad Ragab. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articleSourceURLLabel: UILabel!
    
    // MARK: - Properties
    var article: ArticleModel?
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        setDetails()
    }
    
    // MARK: - Functions
    func setTitle() {
        var title = "N/A"
        if let articleModel = article, let sourceModel = articleModel.source, let sourceName = sourceModel.name {
            title = sourceName
        }
        
        self.title = title
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPS-BoldMT", size: 20)!]
    }
    
    func setDetails() {
        if let articleModel = article {
            
            articleTitleLabel.text = articleModel.title ?? "N/A"
            
            articleAuthorLabel.text = "By: \(articleModel.author ?? "N/A")"
            
            articleDescriptionLabel.text = articleModel.description ?? "N/A"
            
            articleSourceURLLabel.text = "Source URL: \(articleModel.url ?? "N/A")"
        }
    }
}
