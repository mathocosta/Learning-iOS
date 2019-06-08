//
//  LearnContinuousIntegrationTests.swift
//  LearnContinuousIntegrationTests
//
//  Created by Matheus Costa on 06/05/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import XCTest
@testable import LearnContinuousIntegration

class LearnContinuousIntegrationTests: XCTestCase {

    var viewController: ViewController?

    override func setUp() {
        super.setUp()
        self.viewController = ViewController()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSumWithValidResult() {
        let result = self.viewController?.sum(4.0, 4.0)
        XCTAssertNotNil(result, "Verificado se resultado não é nil")
        XCTAssertEqual(result, 8.0, "A soma dos dois valores deve ser igual a 8.0")
    }

    func testSumWithInvalidResult() {
        let result = self.viewController?.sum(2.0, 7.0)
        XCTAssertNotNil(result, "Verificado se resultado não é nil")
        XCTAssertNotEqual(result, 10.0, "A soma dos dois valores deve ser igual a 9.0")
    }

}
