//
//  ProductListPresenter.swift
//  Presentation
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import Foundation
import Domain

protocol ProductSelectionDelegate: AnyObject {

}

protocol ProductListPresenterProtocol {
    func onViewLoaded()
    func onProductSelected()
}

class ProductListPresenter {
    
    let productListView: ProductListViewProtocol
    let getProductListUseCase: GetProductListUseCaseProtocol
    
    let delegate: ProductSelectionDelegate? = nil
    
    init(productListView:ProductListViewProtocol, getProductListUseCase: GetProductListUseCaseProtocol) {
        self.productListView = productListView
        self.getProductListUseCase = getProductListUseCase
    }
    
    func getProductList() {
        self.productListView.setProductListVisibility(visible: false)
        self.productListView.setLoadingViewVisibility(visible: true)
        self.getProductListUseCase.execute { productList in
            self.productListView.setLoadingViewVisibility(visible: false)
            if(productList.isEmpty) {
                self.productListView.showEmptyListMessage()
            } else {
                self.productListView.setProductListVisibility(visible: true)
                self.productListView.showProductList(products: productList)
            }
        }
    }
}

extension ProductListPresenter: ProductListPresenterProtocol {
    func onViewLoaded() {
        self.getProductList()
    }
    
    func onProductSelected() {
        
    }
    
    
}

