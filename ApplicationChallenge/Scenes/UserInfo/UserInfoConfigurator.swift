//
//  UserInfoConfigurator.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import Foundation

class UserInfoConfigurator {
    static func configure(viewController: UserInfoViewController) {
        let interactor = UserInfoInteractor()
        let presenter = UserInfoPresenter()
        let router = UserInfoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
