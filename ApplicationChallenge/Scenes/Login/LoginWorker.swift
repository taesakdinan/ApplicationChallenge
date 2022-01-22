//
//  LoginWorker.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import Foundation

enum LoginWorkerResult {
    enum ValidateData {
        case valid
        case shortUsername
        case shortPassword
        case shortUsernameAndPassword
        case incomplete
    }
}

class LoginWorker {
    
    func validateData(username: String?, password: String?, country: String?) -> LoginWorkerResult.ValidateData {
        guard let username = username,!username.isEmpty,
              let password = password, !password.isEmpty,
                let country = country, !country.isEmpty else {
            return .incomplete
        }
        if username.count < Constants.minimuimLength && password.count < Constants.minimuimLength {
            return .shortUsernameAndPassword
        } else if username.count < Constants.minimuimLength {
            return .shortUsername
        } else if password.count < Constants.minimuimLength {
            return .shortPassword
        } else {
            return .valid
        }
    }
}
