//
//  CurrencyConversorTests.swift
//  DomainTests
//
//  Created by Jaime Alcántara on 19/09/2021.
//

import XCTest
@testable import Domain

class CurrencyConversorTests: XCTestCase {

    var currencyConversor:CurrencyConversor?

    override func setUpWithError() throws {
        self.currencyConversor = CurrencyConversor()
    }

    override func tearDownWithError() throws {
        self.currencyConversor = nil
    }

    func testConversionOfTransactionsFirstData() throws {
        
        var currencyConversionList: [CurrencyConversion]
        var transactionList: [(amount: Decimal, currency: String)]
        
        currencyConversionList = [
            CurrencyConversion(currencyPair: ("USD", "EUR"), rate: 1.31),
            CurrencyConversion(currencyPair: ("EUR", "USD"), rate: 0.76),
            CurrencyConversion(currencyPair: ("USD", "CAD"), rate: 0.89),
            CurrencyConversion(currencyPair: ("CAD", "USD"), rate: 1.12),
            CurrencyConversion(currencyPair: ("EUR", "AUD"), rate: 1.33),
            CurrencyConversion(currencyPair: ("AUD", "EUR"), rate: 0.75)]
        
        self.currencyConversor!.calculateAllRates(currencyConversions: currencyConversionList)
        
        transactionList = [(amount: 5.62, currency: "EUR"), (amount: 3.11, currency: "AUD"), (amount: 6.13, currency: "CAD"), (amount: 1.64, currency: "USD")]
        
        let convertedTransactions = try! self.currencyConversor!.convertTransactionList(finalCurrency: "EUR", transactionList: transactionList)
        
        XCTAssertEqual(convertedTransactions[0].amount.rounded(2, .bankers), Decimal(5.62).rounded(2, .bankers))
        XCTAssertEqual(convertedTransactions[1].amount.rounded(2, .bankers), Decimal(2.34).rounded(2, .bankers))
        XCTAssertEqual(convertedTransactions[2].amount.rounded(2, .bankers), Decimal(8.99).rounded(2, .bankers))
        XCTAssertEqual(convertedTransactions[3].amount.rounded(2, .bankers), Decimal(2.15).rounded(2, .bankers))
        for transaction in convertedTransactions {
            XCTAssertEqual(transaction.currency, "EUR")
        }
    }
    
    func testConversionOfTransactionsSecondData() throws {
        
        var currencyConversionList: [CurrencyConversion]
        var transactionList: [(amount: Decimal, currency: String)]
        
        currencyConversionList = [
            CurrencyConversion(currencyPair: ("EUR", "USD"), rate: 1.359),
            CurrencyConversion(currencyPair: ("CAD", "EUR"), rate: 0.732),
            CurrencyConversion(currencyPair: ("USD", "EUR"), rate: 0.736),
            CurrencyConversion(currencyPair: ("EUR", "USD"), rate: 1.12),
            CurrencyConversion(currencyPair: ("EUR", "CAD"), rate: 1.366)]
        
        self.currencyConversor!.calculateAllRates(currencyConversions: currencyConversionList)
        
        transactionList = [(amount: 10.00, currency: "USD"), (amount: 7.63, currency: "EUR")]
        
        let convertedTransactions = try! self.currencyConversor!.convertTransactionList(finalCurrency: "EUR", transactionList: transactionList)
        
        XCTAssertEqual(convertedTransactions[0].amount.rounded(2, .bankers), Decimal(7.36).rounded(2, .bankers))
        XCTAssertEqual(convertedTransactions[1].amount.rounded(2, .bankers), Decimal(7.63).rounded(2, .bankers))
        for transaction in convertedTransactions {
            XCTAssertEqual(transaction.currency, "EUR")
        }
    }
        
    func testUnknownCurrencyAsResult() throws {
        
        var currencyConversionList: [CurrencyConversion]
        var transactionList: [(amount: Decimal, currency: String)]
        
        currencyConversionList = [CurrencyConversion(currencyPair: ("USD", "EUR"), rate: 1.31),CurrencyConversion(currencyPair: ("EUR", "USD"), rate: 0.76),CurrencyConversion(currencyPair: ("USD", "CAD"), rate: 0.89),CurrencyConversion(currencyPair: ("CAD", "USD"), rate: 1.12),CurrencyConversion(currencyPair: ("EUR", "AUD"), rate: 1.33),CurrencyConversion(currencyPair: ("AUD", "EUR"), rate: 0.75)]
        
        self.currencyConversor!.calculateAllRates(currencyConversions: currencyConversionList)
        
        transactionList = [(amount: 5.62, currency: "EUR"), (amount: 6.13, currency: "CAD")]
        
        XCTAssertThrowsError(try self.currencyConversor!.convertTransactionList(finalCurrency: "GBP", transactionList: transactionList)) { error in
            XCTAssertEqual(error as? CurrencyConversorError, CurrencyConversorError.unknownCurrency(currency: "GBP"))
        }
    }
    
    func testUnknownCurrencyInTransaction() throws {
        
        var currencyConversionList: [CurrencyConversion]
        var transactionList: [(amount: Decimal, currency: String)]
        
        currencyConversionList = [CurrencyConversion(currencyPair: ("USD", "EUR"), rate: 1.31),CurrencyConversion(currencyPair: ("EUR", "USD"), rate: 0.76),CurrencyConversion(currencyPair: ("USD", "CAD"), rate: 0.89),CurrencyConversion(currencyPair: ("CAD", "USD"), rate: 1.12),CurrencyConversion(currencyPair: ("EUR", "AUD"), rate: 1.33),CurrencyConversion(currencyPair: ("AUD", "EUR"), rate: 0.75)]
        
        self.currencyConversor!.calculateAllRates(currencyConversions: currencyConversionList)
        
        transactionList = [(amount: 5.62, currency: "EUR"), (amount: 6.13, currency: "GBP")]
        
        XCTAssertThrowsError(try self.currencyConversor!.convertTransactionList(finalCurrency: "USD", transactionList: transactionList)) { error in
            XCTAssertEqual(error as? CurrencyConversorError, CurrencyConversorError.unknownCurrency(currency: "GBP"))
        }
    }
}
