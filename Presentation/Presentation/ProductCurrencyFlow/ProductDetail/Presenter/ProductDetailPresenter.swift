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

    let productDetailView: ProductDetailViewProtocol
    let getProductAmountsUseCase: GetProductAmountsUseCaseProtocol
    var productCode: String!
    var initialConfigurationDone : Bool
    
    init(productDetailView: ProductDetailViewProtocol, getProductAmountsUseCase: GetProductAmountsUseCaseProtocol) {
        self.initialConfigurationDone = false
        self.productDetailView = productDetailView
        self.getProductAmountsUseCase = getProductAmountsUseCase
    }
    
    func manageAmountsResult(result: Result<[(Decimal, String)], GetProductError>) {
        switch result {
        case .success(let transactionList):
            self.productDetailView.showTransactionList(transactions: transactionList.map { "\($0.0)" + " " + $0.1 })
        case .failure(let error):
            print("Error: " + error.localizedDescription)
        }
    }
    
}

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    func onViewShowed() {
        if(!self.initialConfigurationDone) {
            self.initialConfigurationDone = true
            self.getProductAmountsUseCase.execute(productCode: self.productCode) { result in
                self.manageAmountsResult(result: result)
            }
        }
    }
    
    
}
