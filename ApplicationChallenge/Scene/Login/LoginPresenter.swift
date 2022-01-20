//
//  LoginPresenter.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import UIKit

protocol LoginPresentationLogic {
    func presentSomething(response: Login.Something.Response)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Login.Something.Response) {
        let viewModel = Login.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
