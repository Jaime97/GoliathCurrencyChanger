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
        }.inObjectScope(.container)
        
        container.register(MemoryStorageManagerProtocol.self) { r in
            MemoryStorageManager()
        }.inObjectScope(.container)
        
        container.register(ProductRepositoryProtocol.self) { r in
            ProductRepository(networkManager: r.resolve(Networkable.self)!, memoryStorageManager: r.resolve(MemoryStorageManagerProtocol.self)!)
        }
    }
}
