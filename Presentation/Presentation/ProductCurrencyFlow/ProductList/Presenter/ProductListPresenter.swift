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
    func onViewShowed()
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
        self.getProductListUseCase.execute { result in
            switch result {
            case .success(let productList):
                self.onProductListObtained(productList: productList)
            case .failure(let error):
                self.onGetProductListError(error: error)
            }
        }
    }
    
    func onProductListObtained(productList: [String]) {
        self.productListView.setLoadingViewVisibility(visible: false)
        if(productList.isEmpty) {
            self.productListView.showEmptyListMessage()
        } else {
            self.productListView.setProductListVisibility(visible: true)
            self.productListView.showProductList(products: productList)
        }
    }
    
    func onGetProductListError(error:Error) {
        self.productListView.showAlert(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("product_list_error", comment: ""), buttonTitle: NSLocalizedString("ok", comment: ""))
    }
}

extension ProductListPresenter: ProductListPresenterProtocol {
    func onViewShowed() {
        self.getProductList()
    }
    
    func onProductSelected() {
        
    }
    
    
}

