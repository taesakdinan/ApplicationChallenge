//
//  MockUser.swift
//  ApplicationChallengeTests
//
//  Created by Sakdinan Sukkhasem on 23/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import Foundation
@testable import ApplicationChallenge

final class MockUser {
    func getUsers() -> [User] {
        let data = MockData.contentsOfJson("users")
        let decoder = JSONDecoder()
        return try! decoder.decode([User].self, from: data)
    }
}
