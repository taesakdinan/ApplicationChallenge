//
//  UserInfoInteractorTests.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 23/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

@testable import ApplicationChallenge
import XCTest

class UserInfoInteractorTests: XCTestCase {
    
    var sut: UserInfoInteractor!
        
    override func setUp() {
        super.setUp()
        setupUserInfoInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewControllerStateChangedGetUsersSuccessThenPresentUserInfo() {
        let presentationSpy = UserInfoPresentationLogicSpy()
        sut.presenter = presentationSpy
        let workerSpy = UserInfoWorkerSpy()
        let mockUsers = MockUser().getUsers()
        workerSpy.mockGetUsersResponse = .success(mockUsers)
        sut.worker = workerSpy
        sut.viewControllerStateChanged(state: .viewDidLoad)
        XCTAssert(presentationSpy.presentLoadingCalled)
        XCTAssert(presentationSpy.presentUserInfoCalled)
    }
    
    func testViewControllerStateChangedGetUsersDataIncorrectThenPresentEmprtyAlert() {
        let presentationSpy = UserInfoPresentationLogicSpy()
        sut.presenter = presentationSpy
        let workerSpy = UserInfoWorkerSpy()
        workerSpy.mockGetUsersResponse = .dataIncorrect
        sut.worker = workerSpy
        sut.viewControllerStateChanged(state: .viewDidLoad)
        XCTAssert(presentationSpy.presentLoadingCalled)
        XCTAssert(presentationSpy.presentEmptyAlertCalled)
    }
    
    func testViewControllerStateChangedGetUsersErrorThenPresentAlert() {
        let presentationSpy = UserInfoPresentationLogicSpy()
        sut.presenter = presentationSpy
        let workerSpy = UserInfoWorkerSpy()
        workerSpy.mockGetUsersResponse = .error
        sut.worker = workerSpy
        sut.viewControllerStateChanged(state: .viewDidLoad)
        XCTAssert(presentationSpy.presentLoadingCalled)
        XCTAssert(presentationSpy.presentAlertCalled)
    }
    
    func testUserActionOccuredCloseApplitionPressed() {
        let presentationSpy = UserInfoPresentationLogicSpy()
        sut.presenter = presentationSpy
        let workerSpy = UserInfoWorkerSpy()
        sut.worker = workerSpy
        sut.userActionOccured(userAction: .closeApplitionPressed)
        XCTAssert(presentationSpy.closeApplicationCalled)
    }
    
    func testUserActionOccuredRetryPressed() {
        let presentationSpy = UserInfoPresentationLogicSpy()
        sut.presenter = presentationSpy
        let workerSpy = UserInfoWorkerSpy()
        workerSpy.mockGetUsersResponse = .error
        sut.worker = workerSpy
        sut.viewControllerStateChanged(state: .viewDidLoad)
        let mockUsers = MockUser().getUsers()
        workerSpy.mockGetUsersResponse = .success(mockUsers)
        sut.userActionOccured(userAction: .retryPressed)
        XCTAssert(presentationSpy.presentLoadingCalled)
        XCTAssert(presentationSpy.presentUserInfoCalled)
    }
}

private extension UserInfoInteractorTests {

    func setupUserInfoInteractor() {
        sut = UserInfoInteractor()
    }
        
    class UserInfoPresentationLogicSpy: UserInfoPresentationLogic {
        var presentLoadingCalled = false
        func presentLoading(response: UserInfo.Loading.Response) {
            presentLoadingCalled = true
        }
        
        var presentUserInfoCalled = false
        func presentUserInfo(response: UserInfo.UserInfo.Response) {
            presentUserInfoCalled = true
        }
        
        var presentAlertCalled = false
        func presentAlert() {
            presentAlertCalled = true
        }
        
        var presentEmptyAlertCalled = false
        func presentEmptyAlert() {
            presentEmptyAlertCalled = true
        }
        
        var closeApplicationCalled = false
        func closeApplication() {
            closeApplicationCalled = true
        }
        
        
    }
    
    class UserInfoWorkerSpy: UserInfoWorker {
        var mockGetUsersResponse: UserInfoWorkerResult.Users?
        override func getUsers(completion: @escaping ((UserInfoWorkerResult.Users) -> Void)) {
            guard let mockGetUsersResponse = mockGetUsersResponse else { return }
            completion(mockGetUsersResponse)
        }
    }

}
