//
//  LoginInteractor.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import Foundation

protocol LoginBusinessLogic {
    func doSomething(request: Login.Something.Request)
}

protocol LoginDataStore {
//    var name: String { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
//    var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Login.Something.Request) {
        worker = LoginWorker()
        worker?.doSomeWork()
        
        let response = Login.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
