//
//  LoginInteractor.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import Foundation

enum LoginUserAction {
    case enterUsername
    case enterPassword
    case selectCountry
    case loginPressed
}

protocol LoginBusinessLogic: SceneBusinessLogic {
    func userActionOccured(userAction: LoginUserAction)
}

protocol LoginDataStore {
    var onSelectedCountry: ((_ index: Int?) -> Void)? { get set }
    var countryList: [String] { get }
}

class LoginInteractor: LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    var onSelectedCountry: ((_ index: Int?) -> Void)?
    private(set) var countryList: [String] = []
}

extension LoginInteractor: LoginBusinessLogic {
    func userActionOccured(userAction: LoginUserAction) {
        switch userAction {
        case .enterUsername:
            break
        case .selectCountry:
            prepareCountryListData()
            presenter?.presentCountryList()
        default: break
        }
    }
    
    func viewControllerStateChanged(state: ViewControllerState) {
        switch state {
        case .viewDidLoad:
            handleOnSelectedCountry()
        default: break
        }
    }
}

private extension LoginInteractor {
    func handleOnSelectedCountry() {
        onSelectedCountry = { [weak self] index in
            guard let self = self,
                  let presenter = self.presenter,
                  let index = index else {
                      return
                  }
            let name = self.countryList[index]
            self.countryList = []
            let response = Login.Country.Response(name: name)
            presenter.presentCountry(response: response)
        }
    }
    
    func prepareCountryListData() {
        countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
    }
}

