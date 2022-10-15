//
//  Coin.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

import Foundation

struct Coin: Codable {
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
    
    var dictionary: [String: Any]? {
        get throws {
            let data = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data,
                                                              options: .allowFragments) as? [String: Any]
            return dictionary
        }
    }
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

extension Coin {
    init(from dict: [String : Any]) {
        id = dict["id"] as? String
        icon = dict["icon"] as? String
        name = dict["name"] as? String
        symbol = dict["symbol"] as? String
        rank = dict["rank"] as? Int
        price = dict["price"] as? Double
        priceBtc = dict["priceBtc"] as? Double
        volume = dict["volume"] as? Double
        marketCap = dict["marketCap"] as? Double
        availableSupply = dict["availableSupply"] as? Double
        totalSupply = dict["totalSupply"] as? Double
        priceChange1h = dict["priceChange1h"] as? Double
        priceChange1d = dict["priceChange1d"] as? Double
        priceChange1w = dict["priceChange1w"] as? Double
        websiteUrl = dict["websiteUrl"] as? String
        twitterUrl = dict["twitterUrl"] as? String
        exp = dict["exp"] as? [String]
    }
}
