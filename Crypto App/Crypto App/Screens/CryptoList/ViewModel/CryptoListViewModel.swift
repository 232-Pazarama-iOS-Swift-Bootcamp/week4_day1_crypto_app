//
//  CryptoListViewModel.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

import Foundation
import Moya

enum CryptoListChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchCoins
}

final class CryptoListViewModel {
    private var coinsResponse: CoinsResponse? {
        didSet {
            self.changeHandler?(.didFetchCoins)
        }
    }
    
    var changeHandler: ((CryptoListChanges) -> Void)?
    
    var numberOfRows: Int {
        coinsResponse?.coins?.count ?? .zero
    }
    
    func fetchCoins() {
        provider.request(.coins) { result in
            switch result {
            case .failure(let error):
                self.changeHandler?(.didErrorOccurred(error))
            case .success(let response):
                do {
                    let coinsResponse = try JSONDecoder().decode(CoinsResponse.self, from: response.data)
                    self.coinsResponse = coinsResponse
                } catch {
                    self.changeHandler?(.didErrorOccurred(error))
                }
            }
        }
    }
    
    func coinForIndexPath(_ indexPath: IndexPath) -> Coin? {
        coinsResponse?.coins?[indexPath.row]
    }
}
