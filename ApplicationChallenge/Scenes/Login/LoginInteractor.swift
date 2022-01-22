//
//  LoginInteractor.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import Foundation

enum LoginUserAction {
    case selectCountry
    case loginPressed(request: Login.InputData.Request)
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
    lazy var worker = LoginWorker()
    var onSelectedCountry: ((_ index: Int?) -> Void)?
    private(set) var countryList: [String] = []
}

extension LoginInteractor: LoginBusinessLogic {
    func userActionOccured(userAction: LoginUserAction) {
        switch userAction {
        case .selectCountry:
            prepareCountryListData()
            presenter?.presentCountryList()
        case .loginPressed(let request):
            let result = worker.validateData(username: request.username,
                                             password: request.password,
                                             country: request.country)
            handleValidateResult(result)
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
    
    func handleValidateResult(_ result: LoginWorkerResult.ValidateData) {
        switch result {
        case .valid:
            // TODO: presenter next scene
            break
        case .shortUsernameAndPassword:
            let reponse = Login.Alert.Response(message: AlertMessage.shortUsernameAndPassword.message)
            presenter?.presentAlert(response: reponse)
            presenter?.clearPassword()
        case .shortUsername:
            let reponse = Login.Alert.Response(message: AlertMessage.shortUsername.message)
            presenter?.presentAlert(response: reponse)
            presenter?.clearPassword()
        case .shortPassword:
            let reponse = Login.Alert.Response(message: AlertMessage.shortPassword.message)
            presenter?.presentAlert(response: reponse)
            presenter?.clearPassword()
        default: break
        }
    }
}

private enum AlertMessage {
    case shortUsername
    case shortPassword
    case shortUsernameAndPassword
    
    var message: String {
        switch self {
        case .shortUsername:
            return "Username at least \(Constants.minimuimLength) characters"
        case .shortPassword:
            return "Password at least \(Constants.minimuimLength) characters"
        case .shortUsernameAndPassword:
            return "Username and Password at least \(Constants.minimuimLength) characters"
        }
    }
}

