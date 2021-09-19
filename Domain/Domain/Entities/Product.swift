//
//  Product.swift
//  Domain
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

public class Product {
    let productCode: String
    var transactions: [(amount: Decimal, currency: String)]
    
    public init(productCode:String, amounts: [(Decimal, String)]) {
        self.productCode = productCode
        self.transactions = amounts
    }
    
    public func getProductCode() -> String {
        return self.productCode
    }
    
    public func getProductTransactions() -> [(amount: Decimal, currency: String)] {
        return self.transactions
    }
}
