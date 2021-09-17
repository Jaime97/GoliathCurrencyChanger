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
        container.register(ProductListViewProtocol.self){ _ in  ProductListViewController(nibName: "ProductListViewController", bundle: Bundle(for: ProductListViewController.self)) }
            .initCompleted { r, c in
                let productListViewController = c as! ProductListViewController
                productListViewController.presenter = r.resolve(ProductListPresenterProtocol.self)
            }
        
        container.register(ProductListPresenterProtocol.self) { r in
            ProductListPresenter(productListView: r.resolve(ProductListViewProtocol.self)!, getProductListUseCase: r.resolve(GetProductListUseCaseProtocol.self)!)
        }
    }
    
}
