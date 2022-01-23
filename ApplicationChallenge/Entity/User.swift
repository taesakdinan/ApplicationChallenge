//
//  User.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import Foundation

struct User: Codable, Equatable {
    let id: Int?
    let name: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case address
        case phone
        case website
        case company
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(Int.self, forKey: .id)
        name = try? values.decode(String.self, forKey: .name)
        email = try? values.decode(String.self, forKey: .email)
        address = try? values.decode(Address.self, forKey: .address)
        phone = try? values.decode(String.self, forKey: .phone)
        website = try? values.decode(String.self, forKey: .website)
        company = try? values.decode(Company.self, forKey: .company)
    }
}
