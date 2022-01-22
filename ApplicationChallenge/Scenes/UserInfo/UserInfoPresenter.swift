//
//  UserInfoPresenter.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol UserInfoPresentationLogic {
    func presentSomething(response: UserInfo.Something.Response)
}

class UserInfoPresenter: UserInfoPresentationLogic {
    weak var viewController: UserInfoDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: UserInfo.Something.Response) {
        let viewModel = UserInfo.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
