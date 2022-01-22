//
//  LoginInteractorTests.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

@testable import ApplicationChallenge
import XCTest

final class LoginInteractorTests: XCTestCase {
    
    var sut: LoginInteractor!
        
    override func setUp() {
        super.setUp()
        setupLoginInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUserActionLoginPressedValidateSuccessThenPresentDetailScene() {
        let presentationSpy = LoginPresentationLogicSpy()
        sut.presenter = presentationSpy
        let workerSpy = LoginWorkerSpy()
        workerSpy.validateResult = .valid
        sut.worker = workerSpy
        let request = Login.InputData.Request(username: "username",
                                              password: "password",
                                              country: "country")
        sut.userActionOccured(userAction: .loginPressed(request: request))
        XCTAssert(presentationSpy.presentDetailSceneCalled)
    }
    
    func testUserActionLoginPressedFilledShortUsernameAndPasswordThenPresentAlert() {
        let presentationSpy = LoginPresentationLogicSpy()
        sut.presenter = presentationSpy
        let workerSpy = LoginWorkerSpy()
        workerSpy.validateResult = .shortUsernameAndPassword
        sut.worker = workerSpy
        let request = Login.InputData.Request(username: "user",
                                              password: "pass",
                                              country: "country")
        sut.userActionOccured(userAction: .loginPressed(request: request))
        XCTAssert(presentationSpy.presentAlertCalled)
        XCTAssert(presentationSpy.clearPasswordCalled)
    }
    
    func testUserActionLoginPressedFilledShortUsernameThenPresentAlert() {
        let presentationSpy = LoginPresentationLogicSpy()
        sut.presenter = presentationSpy
        let workerSpy = LoginWorkerSpy()
        workerSpy.validateResult = .shortUsername
        sut.worker = workerSpy
        let request = Login.InputData.Request(username: "user",
                                              password: "password",
                                              country: "country")
        sut.userActionOccured(userAction: .loginPressed(request: request))
        XCTAssert(presentationSpy.presentAlertCalled)
        XCTAssert(presentationSpy.clearPasswordCalled)
    }
    
    func testUserActionLoginPressedFilledShortPasswordThenPresentAlert() {
        let presentationSpy = LoginPresentationLogicSpy()
        sut.presenter = presentationSpy
        let workerSpy = LoginWorkerSpy()
        workerSpy.validateResult = .shortPassword
        sut.worker = workerSpy
        let request = Login.InputData.Request(username: "username",
                                              password: "pass",
                                              country: "country")
        sut.userActionOccured(userAction: .loginPressed(request: request))
        XCTAssert(presentationSpy.presentAlertCalled)
        XCTAssert(presentationSpy.clearPasswordCalled)
    }
    
    func testUserActionSelectCountryThenPresentCountryList() {
        let presentationSpy = LoginPresentationLogicSpy()
        sut.presenter = presentationSpy
        let workerSpy = LoginWorkerSpy()
        sut.worker = workerSpy
        sut.userActionOccured(userAction: .selectCountry)
        XCTAssert(presentationSpy.presentCountryListCalled)
    }
    
    func testUserActionSelectedCountryThenPresentCountry() {
        let presentationSpy = LoginPresentationLogicSpy()
        sut.presenter = presentationSpy
        let workerSpy = LoginWorkerSpy()
        sut.worker = workerSpy
        sut.userActionOccured(userAction: .selectCountry)
        sut.onSelectedCountry?(1)
        XCTAssert(presentationSpy.presentCountryCalled)
    }

}

private extension LoginInteractorTests {

    func setupLoginInteractor() {
        sut = LoginInteractor()
    }
        
    class LoginPresentationLogicSpy: LoginPresentationLogic {
        var presentAlertCalled = false
        func presentAlert(response: Login.Alert.Response) {
            presentAlertCalled = true
        }
        
        var presentCountryCalled = false
        func presentCountry(response: Login.Country.Response) {
            presentCountryCalled = true
        }
        
        var presentCountryListCalled = false
        func presentCountryList() {
            presentCountryListCalled = true
        }
        
        var presentDetailSceneCalled = false
        func presentDetailScene() {
            presentDetailSceneCalled = true
        }
        
        var clearPasswordCalled = false
        func clearPassword() {
            clearPasswordCalled = true
        }
    }
    
    class LoginWorkerSpy: LoginWorker {
        var validateResult: LoginWorkerResult.ValidateData = .incomplete
        override func validateData(username: String?, password: String?, country: String?) -> LoginWorkerResult.ValidateData {
            return validateResult
        }
    }

}
