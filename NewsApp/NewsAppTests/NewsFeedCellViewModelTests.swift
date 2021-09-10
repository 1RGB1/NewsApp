//
//  NewsFeedCellViewModelTests.swift
//  NewsAppTests
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import XCTest
@testable import NewsApp

class NewsFeedCellViewModelTests: XCTestCase {

    var viewModel: NewsFeedCellViewModel?
    
    override func setUpWithError() throws {
        MockupHandler().getMockupModel(jsonFileName: "ArticleModel") { [weak self] (model: ArticleModel) in
            self?.viewModel = NewsFeedCellViewModel(article: model)
        }
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_CellType() {
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel!.type == NewsFeedTableViewCell.self)
    }
    
    func test_CellArticle() {
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel!.article.author == "Brian Heater,Nariko Mizoguchi")
    }
}
