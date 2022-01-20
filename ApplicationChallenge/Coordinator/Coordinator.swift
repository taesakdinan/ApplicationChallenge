//
//  Coordinator.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import UIKit

protocol Coordinatable: NSObjectProtocol {
    var childCoordinators: [Coordinatable] { get set }
    var parentCoordinator: Coordinatable? { get set }
    var navigationController: UINavigationController { get set }
    var finish: (() -> Void)? { get set }
}

extension Coordinatable {
    func addChild(_ coordinatable: Coordinatable) {
        childCoordinators.append(coordinatable)
    }
    
    func childDidFinish(_ coordinatable: Coordinatable) {
        coordinatable.destroy()
        childCoordinators = childCoordinators.filter { $0 !== coordinatable }
    }
    
    func destroy() {
        childCoordinators = []
        finish = nil
        parentCoordinator = nil
    }
}

class Coordinator: NSObject, Coordinatable {
    
    weak var parentCoordinator: Coordinatable?
    unowned var navigationController: UINavigationController
    
    var childCoordinators: [Coordinatable] = []
    var finish: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
