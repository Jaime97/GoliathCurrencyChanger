//
//  GetProductListUseCase.swift
//  Domain
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import Foundation

public protocol GetProductListUseCaseProtocol {
    
    func execute(completion: @escaping (Result<[String], Error>) -> ())
    
}

class GetProductListUseCase: GetProductListUseCaseProtocol {

    let productListRepository: ProductListRepositoryProtocol
    
    init(productListRepository: ProductListRepositoryProtocol) {
        self.productListRepository = productListRepository
    }
    
    func execute(completion: @escaping (Result<[String], Error>) -> ()) {
        DispatchQueue.global().async {
            self.productListRepository.getProductList(completion: { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let productList):
                        completion(.success(productList.map {
                            $0.productCode
                        }))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            })
        }
    }
}
