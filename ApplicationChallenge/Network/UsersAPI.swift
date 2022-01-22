//
//  UsersAPI.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import Foundation
import Moya

enum UsersAPI {
    case users
}

extension UsersAPI: TargetType {
    var baseURL: URL { URL(string: "https://jsonplaceholder.typicode.com")! }
    
    var path: String { "users" }
    
    var method: Moya.Method { .get }
    
    var sampleData: Data { Data() }
    
    var task: Task { .requestPlain }
    
    var headers: [String : String]? { nil }
    
    
}
