//
//  PresentationDependencyManager.swift
//  Presentation
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import Foundation
import Domain
import Swinject

public class PresentationDependencyManager {
    
    public static func setup(container:Container) {
        
        container.register(AlertManager.self) { r in
            AlertManager()
        }
        
        container.register(ProductListViewProtocol.self){ _ in
            ProductListViewController(nibName: "ProductListViewController", bundle: Bundle(for: ProductListViewController.self)) }
            .initCompleted { r, c in
                let productListViewController = c as! ProductListViewController
                productListViewController.presenter = r.resolve(ProductListPresenterProtocol.self)!
                productListViewController.alertManager = r.resolve(AlertManager.self)!
            }
        
        container.register(ProductListPresenterProtocol.self) { r in
            ProductListPresenter(productListView: r.resolve(ProductListViewProtocol.self)!, getProductListUseCase: r.resolve(GetProductListUseCaseProtocol.self)!)
        }
        
        container.register(ProductDetailViewProtocol.self){ _ in
            ProductDetailViewController(nibName: "ProductDetailViewController", bundle: Bundle(for: ProductDetailViewController.self)) }
            .initCompleted { r, c in
                let productDetailViewController = c as! ProductDetailViewController
                productDetailViewController.presenter = r.resolve(ProductDetailPresenterProtocol.self)!
                productDetailViewController.alertManager = r.resolve(AlertManager.self)!
            }
        
        container.register(ProductDetailPresenterProtocol.self) { r in
            ProductDetailPresenter(productDetailView: r.resolve(ProductDetailViewProtocol.self)!, getProductTransactionsUseCase: r.resolve(GetProductTransactionsUseCaseProtocol.self)!, getTransactionTotalUseCase: r.resolve(GetTransactionTotalUseCaseProtocol.self)!)
        }
    }
    
}
