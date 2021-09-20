//
//  ProductCurrencyCoordinator.swift
//  Presentation
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import UIKit
import Swinject

class ProductCurrencyCoordinator:Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
        
    init(container: Container, navigationController: UINavigationController = UINavigationController()) {
        self.container = container
        self.navigationController = navigationController
    }
    
    func start() {
        self.showFirstScreen()
    }
    
}

extension ProductCurrencyCoordinator {
    
    func showFirstScreen() {
        let vc = self.container.resolve(ProductListViewProtocol.self)! as! ProductListViewController
        vc.presenter.delegate = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showSecondScreen(product:String) {
        let vc = self.container.resolve(ProductDetailViewProtocol.self)! as! ProductDetailViewController
        vc.presenter.productCode = product
        self.navigationController.pushViewController(vc, animated: true)
    }
}

extension ProductCurrencyCoordinator: ProductSelectionDelegate {
    
    func onProductSelected(product:String) {
        self.showSecondScreen(product: product)
    }
}

extension ProductCurrencyCoordinator: ProductErrorDelegate {
    
    func onErrorInDetail() {
        self.navigationController.popViewController(animated: true)
    }
}
