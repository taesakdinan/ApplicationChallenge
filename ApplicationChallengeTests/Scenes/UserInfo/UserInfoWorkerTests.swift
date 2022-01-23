//
//  UserInfoWorkerTests.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 23/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

@testable import ApplicationChallenge
import XCTest

class UserInfoWorkerTests: XCTestCase {
    
    var sut: UserInfoWorker!
        
    override func setUp() {
        super.setUp()
        setupUserInfoWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
        
    func setupUserInfoWorker() {
        sut = UserInfoWorker()
    }
    
    func testGetUsersSuccess() {
        let usecaseSpy = UserUseCasesSpy()
        let mockUsers = MockUser().getUsers()
        usecaseSpy.mockGetUsersResponse = .success(mockUsers)
        sut.userUsecase = usecaseSpy
        sut.getUsers { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(mockUsers, users)
            default:
                XCTAssert(false)
            }
        }
    }
    
    func testGetUsersDataIncorrect() {
        let usecaseSpy = UserUseCasesSpy()
        usecaseSpy.mockGetUsersResponse = .dataIncorrect
        sut.userUsecase = usecaseSpy
        sut.getUsers { result in
            switch result {
            case .dataIncorrect:
                XCTAssert(true)
            default:
                XCTAssert(false)
            }
        }
    }
    
    func testGetUsersError() {
        let usecaseSpy = UserUseCasesSpy()
        usecaseSpy.mockGetUsersResponse = .error( "error message")
        sut.userUsecase = usecaseSpy
        sut.getUsers { result in
            switch result {
            case .error:
                XCTAssert(true)
            default:
                XCTAssert(false)
            }
        }
    }
}

private extension UserInfoWorkerTests {
    class UserUseCasesSpy: UserUsecase {
        
        var mockGetUsersResponse: UserUsecaseResult.Users?
        override func getUsers(completion: @escaping ((UserUsecaseResult.Users) -> Void)) {
            guard let mockGetUsersResponse = mockGetUsersResponse else { return }
            completion(mockGetUsersResponse)
        }
    }
}
