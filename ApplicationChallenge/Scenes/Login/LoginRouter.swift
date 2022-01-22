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
//        guard let destinationVC = CountryListViewController.instantiateViewController(dataStore?.onSelectedCountry) else { return }
//        viewController?.present(destinationVC, animated: true)
        guard let dataStore = dataStore else { return }
        let destinationVC = CountryPickerViewController.instantiateViewController()
        destinationVC.dataList = dataStore.countryList
        destinationVC.onSelected = dataStore.onSelectedCountry
        viewController?.present(destinationVC, animated: true)
    }
}
