//
//  LoginConfigurator.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import UIKit

class LoginConfigurator {
    static func configure(viewController: LoginViewController) {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.coordinator = AppCoordinator(navigationController: UINavigationController())
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
