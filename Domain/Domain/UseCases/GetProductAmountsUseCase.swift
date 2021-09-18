//
//  GetProductAmountsInEurosUseCase.swift
//  Domain
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

public enum GetProductError: Error {
    case productNotFound
}

public protocol GetProductAmountsUseCaseProtocol {
    
    func execute(productCode:String, completion: @escaping (Result<[(Decimal, String)], GetProductError>) -> ())
    
}

class GetProductAmountsUseCase: GetProductAmountsUseCaseProtocol {

    let productRepository: ProductRepositoryProtocol
    
    init(productRepository: ProductRepositoryProtocol) {
        self.productRepository = productRepository
    }
    
    func execute(productCode:String, completion: @escaping (Result<[(Decimal, String)], GetProductError>) -> ()) {
        if let product = self.productRepository.findProductInProductList(productCode: productCode) {
            completion(.success(product.amounts))
        } else {
            // TODO: Log product not found
            completion(.failure(.productNotFound))
        }
        
    }
}
