//
//  DetailUnitTest.swift
//  SugarBoxTests
//
//  Created by abdul karim on 22/10/23.
//

import XCTest
@testable import SugarBox

final class DetailUnitTest: XCTestCase {
    
    let data = Bundle.main.decode(DataModel.self, from: "ContentMock.json")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialization() {
        // Arrange
        let content = data.sections?.first?.contents?.first 
        
        // Act
        let viewModel = DetailViewModel(content: content)
        
        // Assert
        XCTAssertNotNil(viewModel.content)
        XCTAssertEqual(viewModel.content, content)
    }

}
