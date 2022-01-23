//
//  UserInfoWorker.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import Foundation

enum UserInfoWorkerResult {
    enum Users {
        case success([User])
        case dataIncorrect
        case error
    }
}

class UserInfoWorker {
    lazy var userUsecase: UserUsecaseInterface = UserUsecase()
    
    func getUsers(completion: @escaping ((UserInfoWorkerResult.Users) -> Void)) {
        userUsecase.getUsers { result in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .dataIncorrect:
                completion(.dataIncorrect)
            case .error:
                completion(.error)
            }
        }
    }
}
