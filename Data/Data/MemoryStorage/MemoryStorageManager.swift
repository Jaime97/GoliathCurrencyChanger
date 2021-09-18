//
//  MemoryStorageManager.swift
//  Data
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

protocol MemoryStorageManagerProtocol {
    
    func saveProductList(productList:[DataProduct])
    func getProductList() -> [DataProduct]
    func findProductBySku(sku:String) -> DataProduct?
}

class MemoryStorageManager: MemoryStorageManagerProtocol {
    
    private var productList:[DataProduct] = []
    
    func findProductBySku(sku: String) -> DataProduct? {
        return productList.first(where: { $0.getSku() == sku })
    }
    
    func saveProductList(productList: [DataProduct]) {
        self.productList = productList
    }
    
    func getProductList() -> [DataProduct] {
        return productList
    }
    
}
