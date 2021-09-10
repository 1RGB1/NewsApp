//
//  NewsFeedDetailsViewModelTests.swift
//  NewsAppTests
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import XCTest
@testable import NewsApp

class NewsFeedDetailsViewModelTests: XCTestCase {
    
    var viewModel: NewsFeedDetailsViewModel?

    override func setUpWithError() throws {
        MockupHandler().getMockupModel(jsonFileName: "ArticleModel") { [weak self] (model: ArticleModel) in
            self?.viewModel = NewsFeedDetailsViewModel(article: model)
        }
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_CellArticle() {
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel!.article.author == "Brian Heater,Nariko Mizoguchi")
    }
    
    func test_Element1() {
        XCTAssertNotNil(viewModel?.getCellsViewModel())
        if let cellsViewModels = viewModel?.getCellsViewModel() {
            if cellsViewModels.count > 0 {
                let imageTextViewModel = cellsViewModels[0] as? ImageTextCellViewModel
                XCTAssertNotNil(imageTextViewModel)
                XCTAssertTrue(imageTextViewModel?.text == "2021-09-10T01:00:11Z".formatDateLike(format: "EEEE, MMM d, yyyy"))
            }
        }
    }
    
    func test_Element2() {
        XCTAssertNotNil(viewModel?.getCellsViewModel())
        if let cellsViewModels = viewModel?.getCellsViewModel() {
            if cellsViewModels.count > 1 {
                let textCellViewModel = cellsViewModels[1] as? TextCellViewModel
                XCTAssertNotNil(textCellViewModel)
            }
        }
    }
    
    func test_Element3() {
        XCTAssertNotNil(viewModel?.getCellsViewModel())
        if let cellsViewModels = viewModel?.getCellsViewModel() {
            if cellsViewModels.count > 2 {
                let textCellViewModel = cellsViewModels[2] as? TextCellViewModel
                XCTAssertNotNil(textCellViewModel)
            }
        }
    }
    
    func test_Element4() {
        XCTAssertNotNil(viewModel?.getCellsViewModel())
        if let cellsViewModels = viewModel?.getCellsViewModel() {
            if cellsViewModels.count > 3 {
                let keyValueCellViewModel = cellsViewModels[3] as? KeyValueCellViewModel
                XCTAssertNotNil(keyValueCellViewModel)
            }
        }
    }
    
    func test_Element5() {
        XCTAssertNotNil(viewModel?.getCellsViewModel())
        if let cellsViewModels = viewModel?.getCellsViewModel() {
            if cellsViewModels.count > 4 {
                let actionKeyValueCellViewModel = cellsViewModels[4] as? ActionKeyValueCellViewModel
                XCTAssertNotNil(actionKeyValueCellViewModel)
            }
        }
    }
    
    func test_Element6() {
        XCTAssertNotNil(viewModel?.getCellsViewModel())
        if let cellsViewModels = viewModel?.getCellsViewModel() {
            if cellsViewModels.count > 5 {
                let keyValueCellViewModel = cellsViewModels[5] as? KeyValueCellViewModel
                XCTAssertNotNil(keyValueCellViewModel)
            }
        }
    }
}
