//
//  ProductListPresenter.swift
//  Presentation
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import Foundation
import Domain

protocol ProductSelectionDelegate: AnyObject {
    func onProductSelected(product:String)
}

protocol ProductListPresenterProtocol {
    
    var delegate: ProductSelectionDelegate? { get set }
    
    func onViewShowed()
    func onProductSelected(name: String)
    func onTableRefresh()
}

class ProductListPresenter {
    
    var delegate: ProductSelectionDelegate?
    let productListView: ProductListViewProtocol
    let getProductListUseCase: GetProductListUseCaseProtocol
    var initialConfigurationDone : Bool
    
    init(productListView:ProductListViewProtocol, getProductListUseCase: GetProductListUseCaseProtocol) {
        self.productListView = productListView
        self.getProductListUseCase = getProductListUseCase
        self.initialConfigurationDone = false
    }
    
    func getProductList() {
        self.productListView.setProductListVisibility(visible: false)
        self.productListView.setLoadingViewVisibility(visible: true)
        self.getProductListUseCase.execute { result in
            self.manageProductListResult(result: result)
        }
    }
    
    func refreshProductList() {
        self.getProductListUseCase.execute { result in
            self.productListView.endRefreshing()
            self.manageProductListResult(result: result)
        }
    }
    
    func manageProductListResult(result: Result<[String], Error>) {
        switch result {
        case .success(let productList):
            self.onProductListObtained(productList: productList)
        case .failure(let error):
            self.onGetProductListError(error: error)
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
        if(!initialConfigurationDone) {
            self.initialConfigurationDone = true
            self.getProductList()
            self.productListView.addRefreshToTable(refreshMessage: NSLocalizedString("pull_to_refresh", comment: ""))
        }
    }
    
    func onProductSelected(name: String) {
        self.delegate?.onProductSelected(product: name)
    }
    
    func onTableRefresh() {
        self.refreshProductList()
    }
}

