//
//  LoginInteractor.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import Foundation

enum LoginUserAction {
    case enterUsername
    case enterPassword
    case selectCountry
    case loginPressed
}

protocol LoginBusinessLogic {
    func userActionOccured(userAction: LoginUserAction)
}

protocol LoginDataStore {
//    var name: String { get set }
}

class LoginInteractor: LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
//    var name: String = ""
    
}

extension LoginInteractor: LoginBusinessLogic {
    func userActionOccured(userAction: LoginUserAction) {
        switch userAction {
        case .enterUsername:
            break
        default: break
        }
    }
}

