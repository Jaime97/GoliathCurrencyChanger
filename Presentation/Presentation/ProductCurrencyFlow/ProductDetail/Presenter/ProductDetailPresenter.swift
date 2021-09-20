//
//  ProductDetailPresenter.swift
//  Presentation
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation
import Domain

protocol ProductErrorDelegate: AnyObject {
    func onErrorInDetail()
}

protocol ProductDetailPresenterProtocol {
    var delegate: ProductErrorDelegate? { get set }
    var productCode: String! { get set }
    
    func onViewShowed()
}

class ProductDetailPresenter {
    
    static let currencyToUseInSum = "EUR"
    
    var delegate: ProductErrorDelegate?

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
        case .failure( _):
            self.productDetailView.showAlert(title: NSLocalizedString("error", bundle:Bundle(for: ProductDetailPresenter.self), comment: ""), message: NSLocalizedString("product_not_found", bundle:Bundle(for: ProductDetailPresenter.self), comment: ""), buttonTitle: NSLocalizedString("ok", bundle:Bundle(for: ProductDetailPresenter.self), comment: "")) {
                self.delegate?.onErrorInDetail()
            }
        }
    }
    
    func manageTransactionTotalResult(result: Result<Decimal, GetTransactionTotalError>) {
        switch result {
        case .success(let transactionTotalValue):
            self.productDetailView.addTotalAmountForThisProduct(totalAmount: "\(transactionTotalValue) " + ProductDetailPresenter.currencyToUseInSum)
        case .failure(let error):
            switch error {
            case .connectionError:
                self.productDetailView.showAlert(title: NSLocalizedString("error", bundle:Bundle(for: ProductDetailPresenter.self), comment: ""), message: NSLocalizedString("conversion_download_error", bundle:Bundle(for: ProductDetailPresenter.self), comment: ""), buttonTitle: NSLocalizedString("ok", bundle:Bundle(for: ProductDetailPresenter.self), comment: ""), handler: nil)
            case .productNotFound:
                self.productDetailView.showAlert(title: NSLocalizedString("error", bundle:Bundle(for: ProductDetailPresenter.self), comment: ""), message: NSLocalizedString("product_not_found", bundle:Bundle(for: ProductDetailPresenter.self), comment: ""), buttonTitle: NSLocalizedString("ok", bundle:Bundle(for: ProductDetailPresenter.self), comment: ""), handler: nil)
            case .unknownCurrency:
                self.productDetailView.showAlert(title: NSLocalizedString("error", bundle:Bundle(for: ProductDetailPresenter.self), comment: ""), message: NSLocalizedString("unknown_amount", bundle:Bundle(for: ProductDetailPresenter.self), comment: ""), buttonTitle: NSLocalizedString("ok", bundle:Bundle(for: ProductDetailPresenter.self), comment: ""), handler: nil)
            }
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
