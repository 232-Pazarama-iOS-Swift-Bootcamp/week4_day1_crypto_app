//
//  User.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 16.10.2022.
//

import Foundation

struct User: Encodable {
    let username: String?
    let email: String?
    let pp: String?
    let favorites: [String]?
}

extension User {
    init(from dict: [String: Any]) {
        username = dict["username"] as? String
        email = dict["email"] as? String
        pp = dict["pp"] as? String
        favorites = dict["favorites"] as? [String]
    }
}
