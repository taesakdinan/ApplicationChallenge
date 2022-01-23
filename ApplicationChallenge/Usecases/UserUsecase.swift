//
//  UserUsecase.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import Foundation
import Moya

enum UserUsecaseResult {
    enum Users {
        case success([User])
        case dataIncorrect
        case error(String)
    }
}

protocol UserUsecaseInterface {
    func getUsers(completion: @escaping ((UserUsecaseResult.Users) -> Void))
}

class UserUsecase: UserUsecaseInterface {
    private let provider = MoyaProvider<UsersAPI>()
    
    func getUsers(completion: @escaping ((UserUsecaseResult.Users) -> Void)) {
        provider.request(.users) { result in
            switch result {
            case.success(let response):
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([User].self, from: response.data)
                    if users.isEmpty {
                        completion(.dataIncorrect)
                    } else {
                        completion(.success(users))
                    }
                } catch let error {
                    completion(.error(error.localizedDescription))
                }
            case .failure(let error):
                completion(.error(error.localizedDescription))
            }
        }
    }
}
