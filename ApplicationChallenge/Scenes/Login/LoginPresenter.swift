//
//  LoginPresenter.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import UIKit

protocol LoginPresentationLogic {
    func presentCountryList()
    func presentCountry(response: Login.Country.Response)
}

class LoginPresenter: LoginPresentationLogic {
    
    weak var viewController: LoginDisplayLogic?
    
    func presentCountryList() {
        viewController?.diplayCountryList()
    }
    
    func presentCountry(response: Login.Country.Response) {
        let viewModel = Login.Country.ViewModel(name: response.name)
        viewController?.displayCountry(viewModel: viewModel)
    }
}
