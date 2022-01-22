//
//  Coordinator.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import UIKit

protocol Cooridinatable: AnyObject {
    func start()
}

class Coordinator: Cooridinatable {
    
    private var childCoordinators: [Cooridinatable] = []
    
    func start() { }
    
    func add(childCoordinator: Cooridinatable) {
        if childCoordinators.firstIndex(where: {  $0 === childCoordinator }) == nil {
            childCoordinators.append(childCoordinator)
        }
    }
    
    func remove(childCoordinator: Cooridinatable) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}
