//
//  CurrencyConversor.swift
//  Domain
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

public enum CurrencyConversorError: Error {
    case unknownCurrency(currency: String)
}

class CurrencyConversor {
    
    var currencies:[String]
    
    var currencyRates:[[Decimal]]
    var numberOfRates:Int
    var currencyRatesCalculated:Bool
    
    init() {
        self.numberOfRates = 0
        self.currencies = [String]()
        self.currencyRates = [[Decimal]]()
        self.currencyRatesCalculated = false
    }
    
    func convertTransactionList(finalCurrency:String, transactionList: [(amount: Decimal, currency: String)]) throws -> [(amount: Decimal, currency: String)] {

        var convertedTransactionList = [(amount: Decimal, currency: String)]()
        guard let finalCurrencyIndex = self.currencies.firstIndex(of: finalCurrency) else {
            throw CurrencyConversorError.unknownCurrency(currency: finalCurrency)
        }
        for transaction in transactionList {
            if(transaction.currency != finalCurrency) {
                guard let initialcurrencyIndex = self.currencies.firstIndex(of: transaction.currency) else {
                    throw CurrencyConversorError.unknownCurrency(currency: transaction.currency)
                }
                let rate = self.currencyRates[finalCurrencyIndex][initialcurrencyIndex]
                convertedTransactionList.append((amount: transaction.amount * rate, currency: finalCurrency))
            } else {
                convertedTransactionList.append(transaction)
            }
        }
        return convertedTransactionList
    }
    
    func areCurrencyRatesCalculated() -> Bool {
        return self.currencyRatesCalculated
    }
    
    func calculateAllRates(currencyConversions:[CurrencyConversion]) {
        self.fillDifferentCurrenciesVector(currencyConversions: currencyConversions)
        
        let currencyNumber = self.currencies.count
        for i in (0...currencyNumber-1) {
            self.currencyRates.append([Decimal]())
            for _ in self.currencies {
                self.currencyRates[i].append(1)
            }
        }
        
        
        let numOfcurrencyChangeRates = ((currencyNumber * currencyNumber) - currencyNumber)/2
        self.fillInitialCurrencyRates(currencyConversions: currencyConversions)
        
        var currencyConversionToFill = currencyConversions
        var i = 0
        while i < currencyConversionToFill.count || self.numberOfRates < numOfcurrencyChangeRates * 2 {
            let firstCurrencyConversion = currencyConversionToFill[i]
            var j = 0
            while j < currencyConversionToFill.count {
                let secondCurrencyConversion = currencyConversionToFill[j]
                if(firstCurrencyConversion.getCurrencyPair().1 == secondCurrencyConversion.getCurrencyPair().0 && firstCurrencyConversion.getCurrencyPair().0 != secondCurrencyConversion.getCurrencyPair().1) {
                    let newCurrencyConversion = CurrencyConversion(currencyPair: (firstCurrencyConversion.getCurrencyPair().0, secondCurrencyConversion.getCurrencyPair().1), rate: firstCurrencyConversion.getRate() * secondCurrencyConversion.getRate())
                    if(!currencyConversionToFill.contains(where: { $0.getCurrencyPair().0 == newCurrencyConversion.getCurrencyPair().0 && $0.getCurrencyPair().1 == newCurrencyConversion.getCurrencyPair().1})) {
                        currencyConversionToFill.append(newCurrencyConversion)
                        saveNewCurrencyRate(currencyConversion: newCurrencyConversion)
                    }
                    
                } else if(firstCurrencyConversion.getCurrencyPair().0 == secondCurrencyConversion.getCurrencyPair().1 && firstCurrencyConversion.getCurrencyPair().1 != secondCurrencyConversion.getCurrencyPair().0) {
                    let newCurrencyConversion = CurrencyConversion(currencyPair: (firstCurrencyConversion.getCurrencyPair().1, secondCurrencyConversion.getCurrencyPair().0), rate: (1/firstCurrencyConversion.getRate()) * (1/secondCurrencyConversion.getRate()))
                    if(!currencyConversionToFill.contains(where: { $0.getCurrencyPair().0 == newCurrencyConversion.getCurrencyPair().0 && $0.getCurrencyPair().1 == newCurrencyConversion.getCurrencyPair().1})) {
                        currencyConversionToFill.append(newCurrencyConversion)
                        saveNewCurrencyRate(currencyConversion: newCurrencyConversion)
                    }
                }
                j += 1
            }
            i += 1
        }
        self.currencyRatesCalculated = true
    }
    
    private func fillDifferentCurrenciesVector(currencyConversions:[CurrencyConversion]) {
        for currencyConversion in currencyConversions {
            if(!self.currencies.contains(currencyConversion.getCurrencyPair().0)){
                self.currencies.append(currencyConversion.getCurrencyPair().0)
            }
            if(!self.currencies.contains(currencyConversion.getCurrencyPair().1)) {
                self.currencies.append(currencyConversion.getCurrencyPair().1)
            }
        }
    }
    
    private func saveNewCurrencyRate(currencyConversion:CurrencyConversion) {
        let toIndex = self.currencies.firstIndex(of: currencyConversion.getCurrencyPair().1)!
        let fromIndex = self.currencies.firstIndex(of: currencyConversion.getCurrencyPair().0)!
        if(self.currencyRates[toIndex][fromIndex] == 1) {
            self.currencyRates[toIndex][fromIndex] = currencyConversion.getRate()
            self.numberOfRates += 1
        }
        if(self.currencyRates[fromIndex][toIndex] == 1) {
            self.currencyRates[fromIndex][toIndex] = 1/currencyConversion.getRate()
            self.numberOfRates += 1
        }
    }
    
    private func fillInitialCurrencyRates(currencyConversions:[CurrencyConversion]) {
        for currencyConversion in currencyConversions {
            saveNewCurrencyRate(currencyConversion: currencyConversion)
        }
    }
    
}
