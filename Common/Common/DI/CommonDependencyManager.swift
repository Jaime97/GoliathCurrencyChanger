//
//  CommonDependencyManager.swift
//  Common
//
//  Created by Jaime Alcántara on 19/09/2021.
//

import Swinject

public class CommonDependencyManager {
    
    public static func setup(container:Container) {
        for category in LogCategory.allCases {
            container.register(LoggerProtocol.self, name: category.rawValue) { r in
                OSLogger(category: category)
            }
        }
    }
}
