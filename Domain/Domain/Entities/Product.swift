//
//  Product.swift
//  Domain
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

public struct Product: Codable {
    let productCode: String
    let amount: String
    let currency: String
    
    public init(productCode: String, amount: String, currency: String) {
        self.productCode = productCode
        self.amount = amount
        self.currency = currency
    }
}
