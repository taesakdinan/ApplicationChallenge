//
//  UserInfoPresenter.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import UIKit

protocol UserInfoPresentationLogic {
    func presentLoading(response: UserInfo.Loading.Response)
    func presentUserInfo(response: UserInfo.UserInfo.Response)
    func presentAlert()
    func presentEmptyAlert()
    func closeApplication()
}

class UserInfoPresenter: UserInfoPresentationLogic {
    weak var viewController: UserInfoDisplayLogic?
    
    func presentLoading(response: UserInfo.Loading.Response) {
        let viewModel = UserInfo.Loading.ViewModel(isShow: response.isShow)
        viewController?.displayLoading(viewModel: viewModel)
    }
    
    func presentUserInfo(response: UserInfo.UserInfo.Response) {
        let viewModel = UserInfo.UserInfo.ViewModel(users: response.users)
        viewController?.displayUsersInfo(viewModel: viewModel)
    }
    
    func presentAlert() {
        let viewModel = UserInfo.Alert.ViewModel(title: "Fail", message: "Something went wrong, please try again")
        viewController?.displayAlert(viewModel: viewModel)
    }
    
    func presentEmptyAlert() {
        let viewModel = UserInfo.Alert.ViewModel(title: "Empty", message: "No data for display")
        viewController?.displayEmptyAlert(viewModel: viewModel)
    }
    
    func closeApplication() {
        viewController?.closeApplication()
    }
}
