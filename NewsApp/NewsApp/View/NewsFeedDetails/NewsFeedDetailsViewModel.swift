//
//  NewsFeedDetailsViewModel.swift
//  NewsApp
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import Foundation
import UIKit

protocol NewsFeedDetailsViewModelProtocol {
    func getCellsViewModel() -> [BaseCellViewModel]
}

enum DetailsKeys: String {
    case author = "Author"
    case source = "Source"
    case content = "Content"
}

struct NewsFeedDetailsViewModel: NewsFeedDetailsViewModelProtocol {
    
    let article: ArticleModel
    
    func getCellsViewModel() -> [BaseCellViewModel] {
        
        var cellsViewModels = [BaseCellViewModel]()
        
        let imageURL = URL(string: article.urlToImage ?? "")
        let imageTextCellViewModel = ImageTextCellViewModel(imageUrl: imageURL, text: article.publishedAt ?? "")
        cellsViewModels.append(imageTextCellViewModel)
        
        if let title = article.title {
            let font = UIFont(name: "HelveticaNeue-Bold", size: 18) ?? .boldSystemFont(ofSize: 18)
            let textCellViewModel = TextCellViewModel(text: title, font: font)
            cellsViewModels.append(textCellViewModel)
        }
        
        if let description = article.description {
            let font = UIFont(name: "HelveticaNeue-Regular", size: 18) ?? .systemFont(ofSize: 18)
            let textCellViewModel = TextCellViewModel(text: description, font: font)
            cellsViewModels.append(textCellViewModel)
        }
        
        if let author = article.author {
            let keyValueViewModel = KeyValueCellViewModel(key: DetailsKeys.author.rawValue, value: author)
            cellsViewModels.append(keyValueViewModel)
        }
        
        if let source = article.source, let sourceName = source.name {
            let sourceURL = URL(string: article.url ?? "")
            let keyValueViewModel = ActionKeyValueCellViewModel(url: sourceURL, key: DetailsKeys.source.rawValue, value: sourceName)
            cellsViewModels.append(keyValueViewModel)
        }
        
        if let content = article.content {
            let keyValueViewModel = KeyValueCellViewModel(key: DetailsKeys.content.rawValue, value: content)
            cellsViewModels.append(keyValueViewModel)
        }
        
        return cellsViewModels
    }
}
