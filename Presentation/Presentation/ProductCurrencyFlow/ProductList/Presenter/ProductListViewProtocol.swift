//
//  ProductListViewProtocol.swift
//  Presentation
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import Foundation

protocol ProductListViewProtocol {
    
    func showProductList(products:[String])
    func showEmptyListMessage()
    func setLoadingViewVisibility(visible:Bool)
    func setProductListVisibility(visible:Bool)
    func showAlert(title:String, message:String, buttonTitle:String)
    
}
