//
//  GetProductAmountsInEurosUseCase.swift
//  Domain
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation
import Common

public enum GetProductError: Error {
    case productNotFound
}

public protocol GetProductAmountsUseCaseProtocol {
    
    func execute(productCode:String, completion: @escaping (Result<[(Decimal, String)], GetProductError>) -> ())
    
}

class GetProductAmountsUseCase: GetProductAmountsUseCaseProtocol {

    private let productRepository: ProductRepositoryProtocol
    private let logger: LoggerProtocol
    
    init(productRepository: ProductRepositoryProtocol, logger: LoggerProtocol) {
        self.productRepository = productRepository
        self.logger = logger
    }
    
    func execute(productCode:String, completion: @escaping (Result<[(Decimal, String)], GetProductError>) -> ()) {
        if let product = self.productRepository.findProductInProductList(productCode: productCode) {
            completion(.success(product.amounts))
        } else {
            self.logger.logError(event: "Product " + productCode + " not found in list", isPrivate: true)
            completion(.failure(.productNotFound))
        }
        
    }
}
