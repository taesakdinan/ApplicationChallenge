//
//  MockData.swift
//  ApplicationChallengeTests
//
//  Created by Sakdinan Sukkhasem on 23/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import Foundation

class MockData {
    static func contentsOfJson(_ fileName: String) -> Data {
        Data(contentsOfJson: fileName, fromBundle: Bundle(for: MockData.self))
    }
}

private extension Data {
    init(contentsOfJson: String, fromBundle: Bundle) {
        if let path = fromBundle.path(forResource: contentsOfJson, ofType: "json") {
            do {
                try self.init(contentsOf: URL(fileURLWithPath: path))
            } catch {
                self.init()
            }
        } else {
            self.init()
        }
    }
}
