//
//  CurrencyConversion.swift
//  Domain
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

public class CurrencyConversion {
    
    let currencyPair: (String, String)
    let rate : Decimal
    
    public init(currencyPair: (String, String), rate : Decimal) {
        self.currencyPair = currencyPair
        self.rate = rate
    }
}
