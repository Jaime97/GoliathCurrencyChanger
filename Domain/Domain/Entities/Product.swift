//
//  Product.swift
//  Domain
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

public class Product {
    let productCode: String
    var amounts: [(Decimal, String)]
    
    public init(productCode:String) {
        self.productCode = productCode
        self.amounts = [(Decimal, String)]()
    }
    
    public func addAmount(amount:Decimal, currency:String) {
        self.amounts.append((amount, currency))
    }
    
    public func getProductCode() -> String {
        return self.productCode
    }
}
