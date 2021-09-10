//
//  ActionKeyValueCellViewModelTests.swift
//  NewsAppTests
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import XCTest
@testable import NewsApp

class ActionKeyValueCellViewModelTests: XCTestCase {

    var viewModel: ActionKeyValueCellViewModel?
        
    override func setUpWithError() throws {
        MockupHandler().getMockupModel(jsonFileName: "ArticleModel") { [weak self] (model: ArticleModel) in
            self?.viewModel = ActionKeyValueCellViewModel(url: URL(string: model.url ?? ""), key: DetailsKeys.source.rawValue, value: model.source?.name)
        }
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_CellType() {
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel!.type == ActionKeyValueTableViewCell.self)
    }
}
