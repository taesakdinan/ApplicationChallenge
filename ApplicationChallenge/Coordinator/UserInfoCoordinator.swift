//
//  UserInfoCoordinator.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import UIKit

class UserInfoCoordinator: Coordinator {
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let destinationVC = UserInfoViewController.instantiateViewController()
        navigationController?.setViewControllers([destinationVC], animated: true)
    }
}
