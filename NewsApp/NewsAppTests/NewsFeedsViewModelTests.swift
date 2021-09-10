//
//  NewsFeedsViewModelTests.swift
//  NewsAppTests
//
//  Created by Ahmad Ragab on 10/09/2021.
//

import XCTest
@testable import NewsApp

class NewsFeedsViewModelTests: XCTestCase {

    var successNewsFeeds: NewsFeedStoreProtocol = NewsFeedsStoreSuccessfullMock()
    var failNewsFeeds: NewsFeedStoreProtocol = NewsFeedsStoreFailureMock()
    var viewModel: NewsFeedsViewModel?
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {}
    
    func test_Success_Mock() {
        
        viewModel = NewsFeedsViewModel(newsFeedStore: successNewsFeeds)
        XCTAssertNotNil(viewModel)
        
        viewModel?.loadNewsFeedsPage(withSuccessBlock: {
            XCTAssertTrue(true)
        }, withFailureBlock: { (errorString) in })
    }
    
    func test_Fail_Mock() {
        
        viewModel = NewsFeedsViewModel(newsFeedStore: failNewsFeeds)
        XCTAssertNotNil(viewModel)
        
        viewModel?.loadNewsFeedsPage(withSuccessBlock: {},
                                     withFailureBlock: { (errorString) in
                                        XCTAssertTrue(errorString != "")
                                     })
    }
}
