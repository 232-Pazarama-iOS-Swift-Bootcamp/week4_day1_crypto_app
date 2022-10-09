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

extension Coin {
    var iconUrl: URL {
        guard let icon = icon,
              let iconUrl = URL(string: icon) else {
            fatalError("icon url not found.")
        }
        return iconUrl
    }
    
    var prettyPrice: String {
        "\(Double(round(100 * (price ?? .zero)) / 100)) ₺"
    }
    
    var change: Double {
        guard let price = price,
              let priceChange1w else { return .zero }
        return Double(round(100 * (price * priceChange1w)) / 100)
    }
    
    var prettyChange: String {
        if change > .zero {
            return "↑ \(change) (\(priceChange1w ?? .zero)%)"
        } else {
            return "↓ \(change) (\(priceChange1w ?? .zero)%)"
        }
    }
}
