//
//  AppCoordinator.swift
//  Presentation
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import Foundation
import UIKit
import Swinject

public class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let container: Container
    var starterCoordinator: Coordinator?
    
    public init(container: Container, window: UIWindow = UIWindow(),
         navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        self.container = container
        self.setupWindow()
        self.setupStarterCoordinator()
    }
    
    func setupWindow() {
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }

    func setupStarterCoordinator() {
        self.starterCoordinator = ProductCurrencyCoordinator(container: self.container, navigationController: self.navigationController)
    }

    public func start() {
        self.starterCoordinator?.start()
    }
}
