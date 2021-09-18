//
//  DomainDependencyManager.swift
//  Domain
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import Foundation
import Swinject

public class DomainDependencyManager {
    public static func setup(container:Container) {
        container.register(GetProductListUseCaseProtocol.self) { r in
            GetProductListUseCase(productRepository: r.resolve(ProductRepositoryProtocol.self)!)
        }
        
        container.register(GetProductAmountsUseCaseProtocol.self) { r in
            GetProductAmountsUseCase(productRepository: r.resolve(ProductRepositoryProtocol.self)!)
        }
    }
}
