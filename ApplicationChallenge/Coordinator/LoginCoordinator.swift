//
//  LoginCoordinator.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    private var navigationController: UINavigationController?
    
    public var onFinishFlow: (() -> Void)?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let destinationVC = LoginViewController.instantiateViewController()
        navigationController?.setViewControllers([destinationVC], animated: true)
    }
}
