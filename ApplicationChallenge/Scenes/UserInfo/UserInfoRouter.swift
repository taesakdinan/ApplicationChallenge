//
//  UserInfoRouter.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import UIKit

@objc protocol UserInfoRoutingLogic {
}

protocol UserInfoDataPassing {
    var dataStore: UserInfoDataStore? { get }
}

class UserInfoRouter: NSObject, UserInfoDataPassing {
    weak var viewController: UserInfoViewController?
    var dataStore: UserInfoDataStore?
}

extension UserInfoRouter: UserInfoRoutingLogic {
    
}
