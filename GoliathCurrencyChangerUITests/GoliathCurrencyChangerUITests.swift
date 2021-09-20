//
//  GoliathCurrencyChangerUITests.swift
//  GoliathCurrencyChangerUITests
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import XCTest

class GoliathCurrencyChangerUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        try super.setUpWithError()
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()
    }

    override func tearDownWithError() throws {
    }


}
