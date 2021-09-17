//
//  AppDelegate+Setup.swift
//  GoliathCurrencyChanger
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import Foundation
import Swinject
import Presentation
import Domain
import Data

extension AppDelegate {
    internal func setupDependencies() {
        DataDependencyManager.setup(container: self.container)
        DomainDependencyManager.setup(container: self.container)
        PresentationDependencyManager.setup(container: self.container)
    }
}
