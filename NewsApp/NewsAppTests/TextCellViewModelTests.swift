//
//  TextCellViewModelTests.swift
//  NewsAppTests
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import XCTest
@testable import NewsApp

class TextCellViewModelTests: XCTestCase {

    var viewModel: TextCellViewModel?
    
    override func setUpWithError() throws {
        MockupHandler().getMockupModel(jsonFileName: "ArticleModel") { [weak self] (model: ArticleModel) in
            self?.viewModel = TextCellViewModel(text: model.title ?? "")
        }
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_CellType() {
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel!.type == TextTableViewCell.self)
    }
}
