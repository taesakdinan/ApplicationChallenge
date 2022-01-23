//
//  Address.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import Foundation

struct Address: Codable, Equatable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Location?
    
    enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        street = try? values.decode(String.self, forKey: .street)
        suite = try? values.decode(String.self, forKey: .suite)
        city = try? values.decode(String.self, forKey: .city)
        zipcode = try? values.decode(String.self, forKey: .zipcode)
        geo = try? values.decode(Location.self, forKey: .geo)
    }
}

struct Location: Codable, Equatable {
    let lat: String?
    let lng: String?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}
