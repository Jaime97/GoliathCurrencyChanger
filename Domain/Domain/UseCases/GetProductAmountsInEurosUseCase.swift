//
//  GetProductAmountsInEurosUseCase.swift
//  Domain
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

public protocol GetProductAmountsInEurosUseCaseProtocol {
    
    func execute(productCode:String, completion: @escaping (Result<[Decimal], Error>) -> ())
    
}

class GetProductAmountsInEurosUseCase: GetProductAmountsInEurosUseCaseProtocol {

    let productRepository: ProductRepositoryProtocol
    
    init(productRepository: ProductRepositoryProtocol) {
        self.productRepository = productRepository
    }
    
    func execute(productCode:String, completion: @escaping (Result<[Decimal], Error>) -> ()) {
        /*DispatchQueue.global().async {
            self.productRepository.getProductList(completion: { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let productList):
                        completion(.success(productList.map {
                            //$0.productCode
                        }))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            })
        }*/
    }
}
