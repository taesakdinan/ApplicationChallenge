//
//  UserInfoModels.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import Foundation

enum UserInfo {
    enum Loading {
        struct Response {
            let isShow: Bool
        }
        typealias ViewModel = Response
    }
    enum UserInfo {
        struct Response {
            let users: [User]
        }
        typealias ViewModel = Response
    }
}
