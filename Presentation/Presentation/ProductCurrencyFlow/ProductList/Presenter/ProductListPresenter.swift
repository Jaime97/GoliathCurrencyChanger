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

class ProductListPresenter {
    
    let productListView: ProductListViewProtocol
    
    let delegate: ProductSelectionDelegate? = nil
    
    init(productListView:ProductListViewProtocol) {
        self.productListView = productListView
    }
    
}
