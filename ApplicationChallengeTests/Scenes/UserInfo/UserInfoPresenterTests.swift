//
//  UserInfoPresenterTests.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 23/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

@testable import ApplicationChallenge
import XCTest

class UserInfoPresenterTests: XCTestCase {
    
    var sut: UserInfoPresenter!
        
    override func setUp() {
        super.setUp()
        setupUserInfoPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPresentLoading() {
        let spy = UserInfoDisplayLogicSpy()
        sut.viewController = spy
        let response = UserInfo.Loading.Response(isShow: true)
        sut.presentLoading(response: response)
        XCTAssert(spy.displayLoadingCalled)
    }
    
    func testPresentUsersInfo() {
        let spy = UserInfoDisplayLogicSpy()
        sut.viewController = spy
        let mockUsers = MockUser().getUsers()
        let response = UserInfo.UserInfo.Response(users: mockUsers)
        sut.presentUserInfo(response: response)
        XCTAssert(spy.displayUsersInfoCalled)
    }
    
    func testPresentAlert() {
        let spy = UserInfoDisplayLogicSpy()
        sut.viewController = spy
        sut.presentAlert()
        XCTAssert(spy.displayAlertCalled)
    }
    
    func testPresentEmptyAlert() {
        let spy = UserInfoDisplayLogicSpy()
        sut.viewController = spy
        sut.presentEmptyAlert()
        XCTAssert(spy.displayEmptyAlertCalled)
    }
    
    func testCloseApplication() {
        let spy = UserInfoDisplayLogicSpy()
        sut.viewController = spy
        sut.closeApplication()
        XCTAssert(spy.closeApplicationCalled)
    }
    
}

private extension UserInfoPresenterTests {

    func setupUserInfoPresenter() {
        sut = UserInfoPresenter()
    }
        
    class UserInfoDisplayLogicSpy: UserInfoDisplayLogic {
        var displayLoadingCalled = false
        func displayLoading(viewModel: UserInfo.Loading.ViewModel) {
            displayLoadingCalled = true
        }
        
        var displayAlertCalled = false
        func displayAlert(viewModel: UserInfo.Alert.ViewModel) {
            displayAlertCalled = true
        }
        
        var displayEmptyAlertCalled = false
        func displayEmptyAlert(viewModel: UserInfo.Alert.ViewModel) {
            displayEmptyAlertCalled = true
        }
        
        var displayUsersInfoCalled = false
        func displayUsersInfo(viewModel: UserInfo.UserInfo.ViewModel) {
            displayUsersInfoCalled = true
        }
        
        var closeApplicationCalled = false
        func closeApplication() {
            closeApplicationCalled = true
        }
        
    }

}
