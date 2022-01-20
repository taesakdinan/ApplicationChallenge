//
//  AppCoordinator.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import Foundation

protocol AppCoordinatable {
    func showUserDetail()
}

class AppCoordinator: Coordinator {}

extension AppCoordinator: AppCoordinatable {
    func showUserDetail() {
    }
}
