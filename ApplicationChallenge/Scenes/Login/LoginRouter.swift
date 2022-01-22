//
//  LoginRouter.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import UIKit

@objc protocol LoginRoutingLogic {
    func navigateToCountryList()
    func navigateToDetailScene()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    

}
// MARK: - LoginRoutingLogic
extension LoginRouter: LoginRoutingLogic {
    func navigateToCountryList() {
        guard let dataStore = dataStore else { return }
        let destinationVC = CountryPickerViewController.instantiateViewController()
        destinationVC.dataList = dataStore.countryList
        destinationVC.onSelected = dataStore.onSelectedCountry
        viewController?.present(destinationVC, animated: true)
    }
    
    func navigateToDetailScene() {
        // TODO: implement
    }
}
