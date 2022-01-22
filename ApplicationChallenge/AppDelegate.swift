//
//  AppDelegate.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var appCoordinator: AppCoordinator = {
        let navigationController = self.window?.rootViewController as! UINavigationController
        
        return AppCoordinator(navigationController: navigationController)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(nibName: nil, bundle: nil)
        window?.makeKeyAndVisible()
        appCoordinator.start()
        return true
    }

}

