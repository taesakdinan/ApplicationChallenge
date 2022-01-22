//
//  LoginModels.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 20/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//

import Foundation

enum Login {
    enum Alert {
        struct Response {
            let message: String
        }
        struct ViewModel {
            let title: String
            let message: String
        }
    }
    enum InputData {
        struct Request {
            let username: String?
            let password: String?
            let country: String?
        }
    }
    enum Country {
        struct Request {
            let text: String
        }
        struct Response {
            let name: String
        }
        typealias ViewModel = Response
    }
}
