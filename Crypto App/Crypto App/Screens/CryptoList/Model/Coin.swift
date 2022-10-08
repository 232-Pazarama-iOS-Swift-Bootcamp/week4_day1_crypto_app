//
//  Coin.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

import Foundation

struct Coin: Decodable {
    let id: String?
    let icon: String?
    let name: String?
    let symbol: String?
    let rank: Int?
    let price: Double?
    let priceBtc: Double?
    let volume: Double?
    let marketCap: Double?
    let availableSupply: Double?
    let totalSupply: Double?
    let priceChange1h: Double?
    let priceChange1d: Double?
    let priceChange1w: Double?
    let websiteUrl: String?
    let twitterUrl: String?
    let exp: [String]?
}
