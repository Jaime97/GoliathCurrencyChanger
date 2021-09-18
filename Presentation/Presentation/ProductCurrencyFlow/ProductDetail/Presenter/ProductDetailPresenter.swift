//
//  ProductDetailPresenter.swift
//  Presentation
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

protocol ProductDetailPresenterProtocol {
    var productName: String! { get set }
}

class ProductDetailPresenter {

    let productDetailView: ProductDetailViewProtocol
    var productName: String!
    
    init(productDetailView: ProductDetailViewProtocol) {
        self.productDetailView = productDetailView
    }
    
}

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    
}
