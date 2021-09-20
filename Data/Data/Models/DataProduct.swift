//
//  DataProduct.swift
//  Data
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

import Foundation

public class DataProduct {
    let sku: String
    var amounts: [(Decimal, String)]
    
    public init(sku:String) {
        self.sku = sku
        self.amounts = [(Decimal, String)]()
    }
    
    public func addAmount(amount:Decimal, currency:String) {
        self.amounts.append((amount, currency))
    }
    
    public func getSku() -> String {
        return self.sku
    }
}
