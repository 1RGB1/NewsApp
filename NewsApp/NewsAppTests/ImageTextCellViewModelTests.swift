//
//  ImageTextCellViewModelTests.swift
//  NewsAppTests
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import XCTest
@testable import NewsApp

class ImageTextCellViewModelTests: XCTestCase {

    var viewModel: ImageTextCellViewModel?
        
    override func setUpWithError() throws {
        MockupHandler().getMockupModel(jsonFileName: "ArticleModel") { [weak self] (model: ArticleModel) in
            var dateString = ""
            if let date = model.publishedAt {
                dateString = date.formatDateLike(format: "EEEE, MMM d, yyyy")
            }
            self?.viewModel = ImageTextCellViewModel(imageUrl: URL(string: model.urlToImage ?? ""), text: dateString)
        }
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_CellType() {
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel!.type == ImageTextTableViewCell.self)
    }
    
    func test_CellPublishAt() {
        XCTAssertNotNil(viewModel)
        
        let dateString = "2021-09-10T01:00:11Z".formatDateLike(format: "EEEE, MMM d, yyyy")
        XCTAssertTrue(viewModel!.text == dateString)
    }
}
