//
//  AppDelegate.swift
//  GoliathCurrencyChanger
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import UIKit
import Swinject
import Presentation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    internal let container = Container()
    private var appCoordinator: AppCoordinator!
    
    func application(_: UIApplication, willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        self.setupDependencies()

        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        
        self.appCoordinator = AppCoordinator(container: self.container, window: self.window!)
        self.appCoordinator.start()
        /*let vc = ProductListViewController()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()*/

        return true
    }


}

