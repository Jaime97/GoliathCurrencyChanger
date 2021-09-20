//
//  DomainDependencyManager.swift
//  Domain
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import Foundation
import Swinject
import Common

public class DomainDependencyManager {
    public static func setup(container:Container) {
        container.register(CurrencyConversorProtocol.self) { r in
            CurrencyConversor()
        }.inObjectScope(.container)
        
        container.register(GetProductListUseCaseProtocol.self) { r in
            GetProductListUseCase(productRepository: r.resolve(ProductRepositoryProtocol.self)!)
        }
        
        container.register(GetProductTransactionsUseCaseProtocol.self) { r in
            GetProductTransactionsUseCase(productRepository: r.resolve(ProductRepositoryProtocol.self)!, logger: r.resolve(LoggerProtocol.self, name: LogCategory.domain.rawValue)!)
        }
        
        container.register(GetTransactionTotalUseCaseProtocol.self) { r in
            GetTransactionTotalUseCase(productRepository: r.resolve(ProductRepositoryProtocol.self)!, currencyConversor: r.resolve(CurrencyConversorProtocol.self)!, logger: r.resolve(LoggerProtocol.self, name: LogCategory.domain.rawValue)!)
        }
    }
}
