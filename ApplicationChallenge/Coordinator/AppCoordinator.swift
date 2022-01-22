//
//  MainCoordinator.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
        startLogin()
    }
    
    private func startLogin() {
        let coor = LoginCoordinator(navigationController: navigationController)
        coor.onFinishFlow = { [weak self, weak coor] in
            guard let self = self, let coor = coor else { return }
            self.startUserInfo()
            self.remove(childCoordinator: coor)
        }
        add(childCoordinator: coor)
        coor.start()
    }
    
    private func startUserInfo() {
        let coor = UserInfoCoordinator(navigationController: navigationController)
        add(childCoordinator: coor)
        coor.start()
    }
}
