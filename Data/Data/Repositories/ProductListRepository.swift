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
                completion(.success(self.mapNetworkProductArrayToProductArray(networkProductList: productList)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func mapNetworkProductArrayToProductArray(networkProductList: [NetworkProduct]) -> [Product] {
        var productList = [Product]()
        for networkProduct in networkProductList {
            if let product = productList.first(where: { $0.getProductCode() == networkProduct.sku}) {
                product.addAmount(amount: networkProduct.amount.toDecimal()!, currency: networkProduct.currency)
            } else {
                let newProduct = Product(productCode: networkProduct.sku)
                newProduct.addAmount(amount: networkProduct.amount.toDecimal()!, currency: networkProduct.currency)
                productList.append(newProduct)
            }
        }
        return productList
    }
}

extension String {
    func toDecimal() -> Decimal? {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter.number(from: self.description) as? Decimal
    }
}
