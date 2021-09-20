//
//  GetProductTransationsUseCaseTests.swift
//  DomainTests
//
//  Created by Jaime Alcántara on 20/09/2021.
//

import XCTest
import Foundation
import Common
@testable import Domain

class GetProductTransationsUseCaseTests: XCTestCase {
    
    var getProductTransactionsUseCase:GetProductTransactionsUseCase!
    var productRepository:MockProductRepository!
    var logger:LoggerProtocol!
    
    override func setUpWithError() throws {
        self.productRepository = MockProductRepository()
        self.logger = OSLogger(category: LogCategory.testing)
        self.getProductTransactionsUseCase = GetProductTransactionsUseCase(productRepository: self.productRepository, logger: self.logger)
    }

    override func tearDownWithError() throws {
        self.productRepository = nil
        self.getProductTransactionsUseCase = nil
        self.logger = nil
    }
    
    func testSuccess() {
        
        let transactionList = [(amount: Decimal(5.62), currency: "EUR"), (amount: Decimal(2.34), currency: "EUR"), (amount: Decimal(8.99), currency: "EUR"), (amount: Decimal(2.15), currency: "EUR")]
        self.productRepository.productToFind = Product(productCode: "CODE1", amounts: transactionList)
        
        let expectation = self.expectation(description: #function)
        
        self.getProductTransactionsUseCase.execute(productCode: "CODE1") { result in
            expectation.fulfill()
            switch result {
            case .success(let transactionList):
                XCTAssertEqual(transactionList[0].0, transactionList[0].0)
                XCTAssertEqual(transactionList[0].1, transactionList[0].1)
                XCTAssertEqual(transactionList[3].0, transactionList[3].0)
                XCTAssertEqual(transactionList[3].1, transactionList[3].1)
            case .failure(_):
                XCTFail()
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testFail() {
        self.productRepository.failGettingProduct = true
        self.productRepository.error = GetProductError.productNotFound
        
        let expectation = self.expectation(description: #function)
        
        self.getProductTransactionsUseCase.execute(productCode: "CODE1") { result in
            expectation.fulfill()
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
}
