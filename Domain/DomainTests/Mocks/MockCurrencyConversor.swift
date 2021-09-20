//
//  MockCurrencyConversor.swift
//  DomainTests
//
//  Created by Jaime Alcántara on 20/09/2021.
//

import Foundation
@testable import Domain

class MockCurrencyConversor {
    
    var convertedTransactionList:[(amount: Decimal, currency: String)]?
    var currencyRatesCalculated:Bool?
    var finalCurrencyUsed:String?
    var error:Error?
    var failToConverTransactions = false
    
}

extension MockCurrencyConversor: CurrencyConversorProtocol {
    func convertTransactionList(finalCurrency:String, transactionList: [(amount: Decimal, currency: String)]) throws -> [(amount: Decimal, currency: String)] {
        self.finalCurrencyUsed = finalCurrency
        if(self.failToConverTransactions) {
            throw self.error!
        }
        return self.convertedTransactionList ?? [(amount: Decimal, currency: String)]()
    }
    
    func areCurrencyRatesCalculated() -> Bool {
        return self.currencyRatesCalculated ?? false
    }
    
    func calculateAllRates(currencyConversions:[CurrencyConversion]) {
        
    }
}
