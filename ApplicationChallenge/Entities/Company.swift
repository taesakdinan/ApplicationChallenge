//
//  Company.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import Foundation

struct Company: Codable, Equatable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }
}
