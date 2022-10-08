//
//  CoinsResponse.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

import Foundation

struct CoinsResponse: Decodable {
    let coins: [Coin]?
}
