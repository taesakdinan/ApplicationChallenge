//
//  Sceneable.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 21/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import Foundation

enum ViewControllerState {
    case viewDidLoad
    case viewWillAppear
    case viewDidAppear
    case viewDidDisappear
}

protocol SceneBusinessLogic {
    func viewControllerStateChanged(state: ViewControllerState)
}
