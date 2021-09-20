//
//  GetProductListUseCaseTests.swift
//  DomainTests
//
//  Created by Jaime Alcántara on 20/09/2021.
//

import XCTest
import Foundation
@testable import Domain

class GetProductListUseCaseTests: XCTestCase {
    
    var getProductListUseCase:GetProductListUseCase!
    var productRepository:MockProductRepository!
    
    override func setUpWithError() throws {
        self.productRepository = MockProductRepository()
        self.getProductListUseCase = GetProductListUseCase(productRepository: self.productRepository)
    }

    override func tearDownWithError() throws {
        self.productRepository = nil
        self.getProductListUseCase = nil
    }
    
    func testSuccess() {
        self.productRepository.productList = [Product(productCode: "CODE1", amounts: [(Decimal, String)]()), Product(productCode: "CODE2", amounts: [(Decimal, String)]()), Product(productCode: "CODE3", amounts: [(Decimal, String)]())]
        
        let expectation = self.expectation(description: #function)
        
        self.getProductListUseCase.execute { result in
            expectation.fulfill()
            switch result {
            case .success(let productList):
                XCTAssertEqual(productList, ["CODE1", "CODE2", "CODE3"])
            case .failure(_):
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testFail() {
        self.productRepository.failGettingProductList = true
        self.productRepository.error = GetTransactionTotalError.connectionError
        
        let expectation = self.expectation(description: #function)
        
        self.getProductListUseCase.execute { result in
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
