//
//  MockProductRepository.swift
//  DomainTests
//
//  Created by Jaime Alcántara on 20/09/2021.
//

import Foundation
@testable import Domain

class MockProductRepository {
    
    var productToFind:Product?
    
    var productList:[Product]?
    
    var currencyConversionList:[CurrencyConversion]?
    
    var failGettingCurrencyConversions = false
    
    var failGettingProduct = false
    
    var error:Error?
    
}

extension MockProductRepository: ProductRepositoryProtocol {
    
    func getProductList(completion: @escaping (Result<[Product], Error>) -> ()) {
        completion(.success(self.productList ?? [Product]()))
    }
    
    func findProductInProductList(productCode:String) -> Product? {
        return self.failGettingProduct ? nil : self.productToFind
    }
    
    func getCurrencyConversions(completion: @escaping (Result<[CurrencyConversion], Error>) -> ()) {
        self.failGettingCurrencyConversions ? completion(.failure(self.error!)) : completion(.success(self.currencyConversionList ?? [CurrencyConversion]()))
    }
}
