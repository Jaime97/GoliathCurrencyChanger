//
//  ProductRepository.swift
//  Data
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation
import Domain
import Common

class ProductRepository {
    
    private let networkManager: Networkable
    private let memoryStorageManager: MemoryStorageManagerProtocol
    private let logger: LoggerProtocol
    private let dataFormatter: DataFormatter
    
    init(networkManager: Networkable, memoryStorageManager: MemoryStorageManagerProtocol, logger: LoggerProtocol, dataFormatter: DataFormatter) {
        self.networkManager = networkManager
        self.memoryStorageManager = memoryStorageManager
        self.logger = logger
        self.dataFormatter = dataFormatter
    }
}

extension ProductRepository: ProductRepositoryProtocol {
    
    func findProductInProductList(productCode: String) -> Product? {
        return self.memoryStorageManager.findProductBySku(sku: productCode)?.toProduct()
    }
    
    func getProductList(completion: @escaping (Result<[Product], Error>) -> ()) {
        self.networkManager.fetchProducts { result in
            switch result {
            case .success(let productList):
                let dataProductList = self.dataFormatter.mapNetworkProductArrayToDataProductArray(networkProductList: productList)
                self.memoryStorageManager.saveProductList(productList: dataProductList)
                completion(.success(dataProductList.map {
                    $0.toProduct()
                }))
            case .failure(let error):
                self.logger.logError(event: "Error getting the product list. Error: " + error.localizedDescription, isPrivate: false)
                completion(.failure(error))
            }
        }
    }
    
    func getCurrencyConversions(completion: @escaping (Result<[CurrencyConversion], Error>) -> ()) {
        self.networkManager.fetchCurrencyConversions { result in
            switch result {
            case .success(let currencyConversionList):
                completion(.success(currencyConversionList.map { $0.toCurrencyConversion() }))
            case .failure(let error):
                self.logger.logError(event: "Error getting the currency conversions. Error: " + error.localizedDescription, isPrivate: false)
                completion(.failure(error))
            }
        }
    }
}


