//
//  CoinStatsAPI.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

import Moya

let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
let provider = MoyaProvider<CoinStatsAPI>(plugins: [plugin])

enum CoinStatsAPI {
    case coins
    case chart(id: String, period: String)
}

// MARK: - TargetType
extension CoinStatsAPI: TargetType {
    // URL: https://api.coinstats.app/public/v1
    var baseURL: URL {
        guard let url = URL(string: "https://api.coinstats.app/public/v1") else {
            fatalError("Base URL not found or not in correct format.")
        }
        return url
    }
    
    // URL: https://api.coinstats.app/public/v1/charts
    var path: String {
        switch self {
        case .coins:
            return "/coins"
        case .chart:
            return "/charts"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    // URL: https://api.coinstats.app/public/v1/charts?coinId=bitcoin&period=1w
    var task: Moya.Task {
        switch self {
        case .coins:
            return .requestPlain
        case .chart(let id, let period):
            let parameters = ["coinId" : id,
                              "period" : period]
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
