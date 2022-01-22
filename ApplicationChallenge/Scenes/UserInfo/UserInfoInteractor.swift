//
//  UserInfoInteractor.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import Foundation

enum UserInfoAction {
    case closeApplitionPressed
    case retryPressed
}

protocol UserInfoBusinessLogic: SceneBusinessLogic {
    func userActionOccured(userAction: UserInfoAction)
}

protocol UserInfoDataStore {
}

class UserInfoInteractor: UserInfoDataStore {
    var presenter: UserInfoPresentationLogic?
    lazy var worker = UserInfoWorker()
}

extension UserInfoInteractor: UserInfoBusinessLogic {
    func userActionOccured(userAction: UserInfoAction) {
        switch userAction {
        case .closeApplitionPressed:
            presenter?.closeApplication()
        case .retryPressed:
            getUsers()
        }
    }
    
    func viewControllerStateChanged(state: ViewControllerState) {
        switch state {
        case .viewDidLoad:
            getUsers()
        default: break
        }
    }
}

private extension UserInfoInteractor {
    func getUsers() {
        presenter?.presentLoading(response: UserInfo.Loading.Response(isShow: true))
        worker.getUsers { [weak self] result in
            guard let self = self, let presenter = self.presenter else { return }
            presenter.presentLoading(response: UserInfo.Loading.Response(isShow: false))
            switch result {
            case .success(let users):
                let response = UserInfo.UserInfo.Response(users: users)
                presenter.presentUserInfo(response: response)
            case .error:
                presenter.presentAlert()
            }
        }
    }
}
