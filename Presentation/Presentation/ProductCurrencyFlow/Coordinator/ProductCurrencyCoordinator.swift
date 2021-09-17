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
        self.navigationController.pushViewController(vc, animated: true)
    }
}

extension ProductCurrencyCoordinator: ProductSelectionDelegate {
    
}
