//
//  CurrencyConversorTests.swift
//  DomainTests
//
//  Created by Jaime Alcántara on 19/09/2021.
//

import XCTest
@testable import Domain

class CurrencyConversorTests: XCTestCase {

    var currencyConversor:CurrencyConversor  = CurrencyConversor()

    override func setUpWithError() throws {
        self.currencyConversor = CurrencyConversor()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        var currencyConversionList = [CurrencyConversion]()
        
        let currencyConversion1 = CurrencyConversion(currencyPair: ("USD", "EUR"), rate: 1.31)
        let currencyConversion2 = CurrencyConversion(currencyPair: ("EUR", "USD"), rate: 0.76)
        let currencyConversion3 = CurrencyConversion(currencyPair: ("USD", "CAD"), rate: 0.89)
        let currencyConversion4 = CurrencyConversion(currencyPair: ("CAD", "USD"), rate: 1.12)
        let currencyConversion5 = CurrencyConversion(currencyPair: ("EUR", "AUD"), rate: 1.33)
        let currencyConversion6 = CurrencyConversion(currencyPair: ("AUD", "EUR"), rate: 0.75)
        currencyConversionList.append(currencyConversion1)
        currencyConversionList.append(currencyConversion2)
        currencyConversionList.append(currencyConversion3)
        currencyConversionList.append(currencyConversion4)
        currencyConversionList.append(currencyConversion5)
        currencyConversionList.append(currencyConversion6)
        
        self.currencyConversor.calculateAllRates(currencyConversions: currencyConversionList)
        
    }

}
