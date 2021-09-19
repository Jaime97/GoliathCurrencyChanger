//
//  ProductDetailViewProtocol.swift
//  Presentation
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

protocol ProductDetailViewProtocol {
    
    func showTransactionList(transactions: [String])
    func addProductCodeToTitle(productCode: String)
    func addTotalAmountForThisProduct(totalAmount: String)
    func setLoadingViewVisibility(visible:Bool)
    func setTotalAmountActivityIndicatorVisibility(visible:Bool)
    
}
