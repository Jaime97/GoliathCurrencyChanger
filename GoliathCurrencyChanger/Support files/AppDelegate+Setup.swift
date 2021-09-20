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
import Common

extension AppDelegate {
    internal func setupDependencies() {
        CommonDependencyManager.setup(container: self.container)
        DataDependencyManager.setup(container: self.container)
        DomainDependencyManager.setup(container: self.container)
        PresentationDependencyManager.setup(container: self.container)
    }
}
