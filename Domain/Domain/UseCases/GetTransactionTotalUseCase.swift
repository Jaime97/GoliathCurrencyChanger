//
//  GetTransactionTotalInEurosUseCase.swift
//  Domain
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation
import Common

public enum GetTransactionTotalError: Error {
    case productNotFound
    case connectionError
    case unknownCurrency
}

public protocol GetTransactionTotalUseCaseProtocol {
    
    func execute(finalCurrency: String, productCode:String, completion: @escaping (Result<Decimal, GetTransactionTotalError>) -> ())
    
}

class GetTransactionTotalUseCase: GetTransactionTotalUseCaseProtocol {

    let productRepository: ProductRepositoryProtocol
    let currencyConversor: CurrencyConversor
    let logger: LoggerProtocol
    
    init(productRepository: ProductRepositoryProtocol, currencyConversor: CurrencyConversor, logger: LoggerProtocol) {
        self.productRepository = productRepository
        self.currencyConversor = currencyConversor
        self.logger = logger
    }
    
    func execute(finalCurrency: String, productCode:String, completion: @escaping (Result<Decimal, GetTransactionTotalError>) -> ()) {
        DispatchQueue.global().async {
            if let product = self.productRepository.findProductInProductList(productCode: productCode) {
                if(!self.currencyConversor.areCurrencyRatesCalculated()) {
                    self.productRepository.getCurrencyConversions { result in
                        switch result {
                        case .success(let currencyConversionList):
                            self.currencyConversor.calculateAllRates(currencyConversions: currencyConversionList)
                            
                            self.convertAndSumTransactions(finalCurrency: finalCurrency, product: product){ result in
                                self.executeCompletion(result: .success(result.rounded(2, .bankers)), completion: completion)
                            } onError: {
                                self.logger.logError(event: "Unknown currency for converter.", isPrivate: false)
                                self.executeCompletion(result: .failure(.unknownCurrency), completion: completion)
                            }
                            
                        case .failure(let error):
                            self.logger.logError(event: "Error getting currency conversions. Error " + error.localizedDescription, isPrivate: false)
                            self.executeCompletion(result: .failure(.connectionError), completion: completion)
                        }
                    }
                } else {

                    self.convertAndSumTransactions(finalCurrency: finalCurrency, product: product){ result in
                        self.executeCompletion(result: .success(result.rounded(2, .bankers)), completion: completion)
                    } onError: {
                        self.executeCompletion(result: .failure(.unknownCurrency), completion: completion)
                    }
                }
                
            } else {
                self.logger.logError(event: "Product not found when trying to get its transaction total amount", isPrivate: false)
                self.executeCompletion(result: .failure(.productNotFound), completion: completion)
            }
        }
    }
    
    private func executeCompletion(result:Result<Decimal, GetTransactionTotalError>, completion: @escaping (Result<Decimal, GetTransactionTotalError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    private func convertAndSumTransactions(finalCurrency: String, product: Product, onSuccess: @escaping (Decimal) -> (), onError: @escaping () -> ()) {
        do {
            let convertedTransactions = try self.currencyConversor.convertTransactionList(finalCurrency: finalCurrency, transactionList: product.getProductTransactions())
            onSuccess(convertedTransactions.reduce(Decimal.init(), {
                $0 + $1.amount
            }))
        } catch CurrencyConversorError.unknownCurrency(currency: let currency) {
            self.logger.logError(event: "Unknown currency " + currency, isPrivate: false)
            onError()
        }catch {
            self.logger.logError(event: "Error during transaction convert. Error " + error.localizedDescription, isPrivate: false)
            onError()
        }
    }
}
