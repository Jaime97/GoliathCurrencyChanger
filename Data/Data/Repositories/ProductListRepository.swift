//
//  ProductListRepository.swift
//  Data
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation
import Domain

class ProductListRepository: ProductListRepositoryProtocol {
    
    private let networkManager: Networkable
    
    init(networkManager: Networkable) {
        self.networkManager = networkManager
    }
    
    func getProductList(completion: @escaping (Result<[Product], Error>) -> ()) {
        self.networkManager.fetchProducts(completion: { result in
            switch result {
            case .success(let productList):
                completion(.success(productList.map {
                    $0.toProduct()
                }))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

extension NetworkProduct {
    
    func toProduct() -> Product {
        return Product(productCode: self.sku, amount: self.amount, currency: self.currency)
    }
    
}
