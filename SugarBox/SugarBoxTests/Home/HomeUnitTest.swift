//
//  HomeUnitTest.swift
//  SugarBoxTests
//
//  Created by abdul karim on 22/10/23.
//

import XCTest
@testable import SugarBox

final class HomeUnitTest: XCTestCase {
    
    let data = Bundle.main.decode(DataModel.self, from: "ContentMock.json")
    
    class MockAPIService: APIService {
        var mockContents: [String: Any]?
        
        override func getContents(queryParams: [String: Any]) async throws -> [String: Any] {
            if let contents = mockContents {
                return contents
            }
            throw APIError.unauthorized // Modify as needed
        }
    }
    
    var viewModel: HomeViewModel!
    var mockAPIService: MockAPIService!

    override func setUpWithError() throws {
        mockAPIService = MockAPIService()
        viewModel = HomeViewModel(apiService: mockAPIService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockAPIService = nil
    }

    func testGetLatestDataSuccess() {
        // Arrange
        let contentJSON: [String: Any] = [
            "data" :[
                "title": "Zee5 Carousel"
            ]

        ]
        mockAPIService.mockContents = contentJSON

        let expectation = XCTestExpectation(description: "Data should be loaded")

        // Act
        viewModel.getLatestData()

        // Assert
        DispatchQueue.main.async {
            XCTAssertNil(self.viewModel.dataModel?.sections?.first?.title, "Zee5 Carousel")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5) // Adjust the timeout as needed
    }

    func testGetLatestDataFailure() {
        mockAPIService.mockContents = nil // Simulate a failure
        let expectation = XCTestExpectation(description: "Data should not be loaded")
        viewModel.getLatestData()
        DispatchQueue.main.async {
            XCTAssertNil(self.viewModel.dataModel)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
}
