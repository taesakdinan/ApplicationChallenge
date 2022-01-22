//
//  LoginPresenterTests.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import XCTest
@testable import ApplicationChallenge

final class LoginPresenterTests: XCTestCase {
    
    private var sut: LoginPresenter!
        
    override func setUp() {
        super.setUp()
        setupLoginPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPresentAlert() {
        let spy = LoginDisplayLogicSpy()
        sut.viewController = spy
        let response = Login.Alert.Response(message: "message")
        sut.presentAlert(response: response)
        XCTAssert(spy.displayAlertCalled)
    }
    
    func testPresentCountry() {
        let spy = LoginDisplayLogicSpy()
        sut.viewController = spy
        let response = Login.Country.Response(name: "message")
        sut.presentCountry(response: response)
        XCTAssert(spy.displayCountryCalled)
    }
    
    func testPresentCountrylist() {
        let spy = LoginDisplayLogicSpy()
        sut.viewController = spy
        sut.presentCountryList()
        XCTAssert(spy.displayCountryListCalled)
    }
    
    func testPresentDetailScene() {
        let spy = LoginDisplayLogicSpy()
        sut.viewController = spy
        sut.presentDetailScene()
        XCTAssert(spy.displayDetailSceneCalled)
    }
    
    func testClearPassword() {
        let spy = LoginDisplayLogicSpy()
        sut.viewController = spy
        sut.clearPassword()
        XCTAssert(spy.clearPasswordCalled)
    }
}

private extension LoginPresenterTests {
    func setupLoginPresenter() {
        sut = LoginPresenter()
    }
        
    class LoginDisplayLogicSpy: LoginDisplayLogic {
        
        var displayAlertCalled = false
        func displayAlert(viewModel: Login.Alert.ViewModel) {
            displayAlertCalled = true
        }
        
        var displayCountryCalled = false
        func displayCountry(viewModel: Login.Country.ViewModel) {
            displayCountryCalled = true
        }
        
        var displayCountryListCalled = false
        func displayCountryList() {
            displayCountryListCalled = true
        }
        var displayDetailSceneCalled = false
        func displayDetailScene() {
            displayDetailSceneCalled = true
        }
        
        var clearPasswordCalled = false
        func clearPassword() {
            clearPasswordCalled = true
        }
    }
}
