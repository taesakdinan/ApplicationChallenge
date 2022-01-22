//
//  LoginPresenter.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import UIKit

protocol LoginPresentationLogic {
    func presentAlert(response: Login.Alert.Response)
    func presentCountry(response: Login.Country.Response)
    func presentCountryList()
    func presentDetailScene()
    func clearPassword()
}

class LoginPresenter: LoginPresentationLogic {
    
    weak var viewController: LoginDisplayLogic?
    
    func presentAlert(response: Login.Alert.Response) {
        let viewModel = Login.Alert.ViewModel(title: "Fail", message: response.message)
        viewController?.displayAlert(viewModel: viewModel)
    }
    
    func presentCountry(response: Login.Country.Response) {
        let viewModel = Login.Country.ViewModel(name: response.name)
        viewController?.displayCountry(viewModel: viewModel)
    }
    
    func presentCountryList() {
        viewController?.displayCountryList()
    }
    
    func presentDetailScene() {
        viewController?.displayDetailScene()
    }
    
    func clearPassword() {
        viewController?.clearPassword()
    }
}
