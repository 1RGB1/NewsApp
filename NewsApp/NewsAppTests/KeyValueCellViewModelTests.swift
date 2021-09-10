//
//  KeyValueCellViewModelTests.swift
//  NewsAppTests
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import XCTest
@testable import NewsApp

class KeyValueCellViewModelTests: XCTestCase {

    var viewModel: KeyValueCellViewModel?
        
    override func setUpWithError() throws {
        MockupHandler().getMockupModel(jsonFileName: "ArticleModel") { [weak self] (model: ArticleModel) in
            self?.viewModel = KeyValueCellViewModel(key: DetailsKeys.author.rawValue, value: model.author)
        }
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_CellType() {
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel!.type == KeyValueTableViewCell.self)
    }
}
