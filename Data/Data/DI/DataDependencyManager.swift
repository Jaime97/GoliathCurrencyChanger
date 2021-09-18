//
//  DataDependencyManager.swift
//  Data
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import Foundation
import Swinject
import Domain

public class DataDependencyManager {
    public static func setup(container:Container) {
        
        container.register(Networkable.self) { r in
            NetworkManager()
        }
        
        container.register(ProductListRepositoryProtocol.self) { r in
            ProductListRepository(networkManager: r.resolve(Networkable.self)!)
        }
    }
}
