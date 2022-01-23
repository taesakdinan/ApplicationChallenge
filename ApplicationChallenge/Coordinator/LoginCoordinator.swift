//
//  LoginCoordinator.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import UIKit

protocol LoginCoordinatable {
    func showCountryPicker(dataList: [String],currentIndexSelected: Int, onSelected: ((_ index: Int) -> Void)?)
    func showuserInfo()
}

class LoginCoordinator: Coordinator {
    var onFinishFlow: (() -> Void)?
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let destinationVC = LoginViewController.instantiateViewController()
        destinationVC.coordinator = self
        navigationController?.setViewControllers([destinationVC], animated: true)
    }
}

extension LoginCoordinator: LoginCoordinatable {
    func showCountryPicker(dataList: [String],currentIndexSelected: Int, onSelected: ((_ index: Int) -> Void)?) {
        let destinationVC = CountryPickerViewController.instantiateViewController(dataList: dataList,
                                                                                  currentIndexSelected: currentIndexSelected,
                                                                                  onSelected: onSelected)
        let newNav = UINavigationController()
        newNav.modalPresentationStyle = .overFullScreen
        newNav.pushViewController(destinationVC, animated: true)
        navigationController?.present(newNav, animated: true)
    }
    
    func showuserInfo() {
        onFinishFlow?()
    }
}
