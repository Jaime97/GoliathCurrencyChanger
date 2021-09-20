//
//  GetTransactionTotalUseCaseTests.swift
//  DomainTests
//
//  Created by Jaime Alcántara on 20/09/2021.
//

import XCTest
import Common
@testable import Domain

class GetTransactionTotalUseCaseTests: XCTestCase {
    
    var currencyConversor:MockCurrencyConversor!
    var getTransactionTotalUseCase:GetTransactionTotalUseCase!
    var logger:LoggerProtocol!
    var productRepository:MockProductRepository!

    override func setUpWithError() throws {
        self.currencyConversor = MockCurrencyConversor()
        self.logger = OSLogger(category: LogCategory.testing)
        self.productRepository = MockProductRepository()
        self.getTransactionTotalUseCase = GetTransactionTotalUseCase(productRepository: self.productRepository, currencyConversor: self.currencyConversor, logger: self.logger)
    }

    override func tearDownWithError() throws {
        self.currencyConversor = nil
        self.logger = nil
        self.productRepository = nil
        self.getTransactionTotalUseCase = nil
    }
    
    func testTransactionSumFirstData() {
        
        self.productRepository.productToFind = Product(productCode: "C0D3", amounts: [(Decimal, String)]())
        self.productRepository.currencyConversionList = [CurrencyConversion]()
        self.currencyConversor.currencyRatesCalculated = false
        
        self.currencyConversor.convertedTransactionList = [(amount: 5.62, currency: "EUR"), (amount: 2.34, currency: "EUR"), (amount: 8.99, currency: "EUR"), (amount: 2.15, currency: "EUR")]
        
        let expectation = self.expectation(description: #function)
        self.getTransactionTotalUseCase.execute(finalCurrency: "EUR", productCode: "C0D3") { result in
            expectation.fulfill()
            XCTAssertEqual(result, .success(Decimal(19.1).rounded(2, .bankers)))
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertEqual(self.currencyConversor.finalCurrencyUsed, "EUR")
    }
    
    func testTransactionSumSecondData() {
        
        self.productRepository.productToFind = Product(productCode: "C0D3", amounts: [(Decimal, String)]())
        self.productRepository.currencyConversionList = [CurrencyConversion]()
        self.currencyConversor.currencyRatesCalculated = false
        
        self.currencyConversor.convertedTransactionList = [(amount: 7.36, currency: "USD"), (amount: 7.63, currency: "USD")]
        
        let expectation = self.expectation(description: #function)
        self.getTransactionTotalUseCase.execute(finalCurrency: "USD", productCode: "C0D3") { result in
            expectation.fulfill()
            XCTAssertEqual(result, .success(Decimal(14.99).rounded(2, .bankers)))
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertEqual(self.currencyConversor.finalCurrencyUsed, "USD")
    }
    
    func testFailGettingCurrencyConversions() {
        
        self.productRepository.productToFind = Product(productCode: "C0D3", amounts: [(Decimal, String)]())
        self.productRepository.failGettingCurrencyConversions = true
        self.productRepository.error = GetTransactionTotalError.connectionError
        self.currencyConversor.currencyRatesCalculated = false
        
        let expectation = self.expectation(description: #function)
        self.getTransactionTotalUseCase.execute(finalCurrency: "USD", productCode: "C0D3") { result in
            expectation.fulfill()
            XCTAssertEqual(result, .failure(GetTransactionTotalError.connectionError))
        }
        waitForExpectations(timeout: 10)
    }
    
    func testFailProductNotFound() {
        
        self.productRepository.productToFind =  Product(productCode: "C0D3", amounts: [(Decimal, String)]())
        self.productRepository.failGettingProduct = true
        self.productRepository.error = GetTransactionTotalError.productNotFound
        self.currencyConversor.currencyRatesCalculated = false
        
        let expectation = self.expectation(description: #function)
        self.getTransactionTotalUseCase.execute(finalCurrency: "USD", productCode: "C0D3") { result in
            expectation.fulfill()
            XCTAssertEqual(result, .failure(GetTransactionTotalError.productNotFound))
        }
        waitForExpectations(timeout: 10)
    }
    
    func testFailUnknownCurrency() {
        
        self.productRepository.productToFind =  Product(productCode: "C0D3", amounts: [(Decimal, String)]())
        self.currencyConversor.error = CurrencyConversorError.unknownCurrency(currency: "USD")
        self.currencyConversor.currencyRatesCalculated = false
        self.currencyConversor.failToConverTransactions = true
        
        let expectation = self.expectation(description: #function)
        self.getTransactionTotalUseCase.execute(finalCurrency: "USD", productCode: "C0D3") { result in
            expectation.fulfill()
            XCTAssertEqual(result, .failure(GetTransactionTotalError.unknownCurrency))
        }
        waitForExpectations(timeout: 10)
    }
    
}
