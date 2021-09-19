//
//  ProductDetailPresenter.swift
//  Presentation
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation
import Domain

protocol ProductDetailPresenterProtocol {
    var productCode: String! { get set }
    
    func onViewShowed()
}

class ProductDetailPresenter {
    
    static let currencyToUseInSum = "EUR"

    let productDetailView: ProductDetailViewProtocol
    let getProductTransactionsUseCase: GetProductTransactionsUseCaseProtocol
    let getTransactionTotalUseCase: GetTransactionTotalUseCaseProtocol
    var productCode: String!
    var initialConfigurationDone : Bool
    
    init(productDetailView: ProductDetailViewProtocol, getProductTransactionsUseCase: GetProductTransactionsUseCaseProtocol, getTransactionTotalUseCase: GetTransactionTotalUseCaseProtocol) {
        self.initialConfigurationDone = false
        self.productDetailView = productDetailView
        self.getProductTransactionsUseCase = getProductTransactionsUseCase
        self.getTransactionTotalUseCase = getTransactionTotalUseCase
    }
    
    func manageTransactionsResult(result: Result<[(Decimal, String)], GetProductError>) {
        switch result {
        case .success(let transactionList):
            self.productDetailView.showTransactionList(transactions: transactionList.map { "\($0.0)" + " " + $0.1 })
        case .failure(let error):
            print("Error: " + error.localizedDescription)
        }
    }
    
    func manageTransactionTotalResult(result: Result<Decimal, GetTransactionTotalError>) {
        switch result {
        case .success(let transactionTotalValue):
            self.productDetailView.addTotalAmountForThisProduct(totalAmount: "\(transactionTotalValue) " + ProductDetailPresenter.currencyToUseInSum)
        case .failure(let error):
            print("Error: " + error.localizedDescription)
        }
    }
    
}

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    func onViewShowed() {
        if(!self.initialConfigurationDone) {
            self.initialConfigurationDone = true
            self.productDetailView.setTotalAmountActivityIndicatorVisibility(visible: true)
            self.productDetailView.addProductCodeToTitle(productCode: self.productCode)
            self.productDetailView.setLoadingViewVisibility(visible: true)
            self.getProductTransactionsUseCase.execute(productCode: self.productCode) { result in
                self.productDetailView.setLoadingViewVisibility(visible: false)
                self.manageTransactionsResult(result: result)
            }
            self.getTransactionTotalUseCase.execute(finalCurrency: ProductDetailPresenter.currencyToUseInSum, productCode: self.productCode) { result in
                self.productDetailView.setTotalAmountActivityIndicatorVisibility(visible: false)
                self.manageTransactionTotalResult(result: result)
            }
        }
    }
    
}
