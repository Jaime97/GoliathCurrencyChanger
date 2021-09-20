//
//  DataFormatter.swift
//  Data
//
//  Created by Jaime Alcántara on 20/09/2021.
//

import Foundation
import Domain

class DataFormatter {
    
    func mapNetworkProductArrayToDataProductArray(networkProductList: [NetworkProduct]) -> [DataProduct] {
        var productList = [DataProduct]()
        for networkProduct in networkProductList {
            if let product = productList.first(where: { $0.getSku() == networkProduct.sku}) {
                product.addAmount(amount: networkProduct.amount.toDecimal()!, currency: networkProduct.currency)
            } else {
                let newProduct = DataProduct(sku: networkProduct.sku)
                newProduct.addAmount(amount: networkProduct.amount.toDecimal()!, currency: networkProduct.currency)
                productList.append(newProduct)
            }
        }
        return productList
    }
}

extension NetworkCurrencyConversion {
    
    func toCurrencyConversion() -> CurrencyConversion {
        return CurrencyConversion(currencyPair: (self.from, self.to), rate: self.rate.toDecimal()!)
    }
}

extension DataProduct {
    
    func toProduct() -> Product {
        return Product(productCode: self.sku, amounts: self.amounts)
    }
}
