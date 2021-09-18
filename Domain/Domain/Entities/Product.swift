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
    
    public init(productCode:String, amounts: [(Decimal, String)]) {
        self.productCode = productCode
        self.amounts = amounts
    }
    
    public func getProductCode() -> String {
        return self.productCode
    }
}
