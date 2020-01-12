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
    @IBOutlet weak private var articleTitleLabel: UILabel!
    @IBOutlet weak private var articleAuthorLabel: UILabel!
    @IBOutlet weak private var articleDescriptionLabel: UILabel!
    @IBOutlet weak private var articleSourceURLLabel: UILabel!
    
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
            
            if let title = articleModel.title, title != "" {
                articleTitleLabel.text = title
            } else {
                articleTitleLabel.text = "Title: N/A"
            }

            if let author = articleModel.author, author != "" {
                articleAuthorLabel.text = "By: \(author)"
            } else {
                articleAuthorLabel.text = "By: N/A"
            }

            if let description = articleModel.description, description != "" {
                articleDescriptionLabel.text = description
            } else {
                articleDescriptionLabel.text = "No description available"
            }
            
            if let url = articleModel.url, url != "" {
                articleSourceURLLabel.text = "Source URL: \(url)"
            } else {
                articleSourceURLLabel.text = "Source URL: N/A"
            }

        }
    }
}
