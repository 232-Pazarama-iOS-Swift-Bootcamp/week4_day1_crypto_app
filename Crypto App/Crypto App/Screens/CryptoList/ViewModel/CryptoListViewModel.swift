//
//  CryptoListViewModel.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

import Foundation
import Moya
import FirebaseFirestore

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
    
    private let db = Firestore.firestore()
    
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
                    
                    self.addCoinsToFirebaseFirestore(coinsResponse.coins)
                    
                    self.coinsResponse = coinsResponse
                } catch {
                    self.changeHandler?(.didErrorOccurred(error))
                }
            }
        }
    }
    
    private func addCoinsToFirebaseFirestore(_ coins: [Coin]?) {
        guard let coins = coins else {
            return
        }
        coins.forEach { coin in
            do {
                guard let data = try coin.dictionary, let id = coin.id else {
                    return
                }
                
                db.collection("coins").document(id).setData(data) { error in
                    
                    if let error = error {
                        self.changeHandler?(.didErrorOccurred(error))
                    }
                }
            } catch {
                self.changeHandler?(.didErrorOccurred(error))
            }
        }
    }
    
    func coinForIndexPath(_ indexPath: IndexPath) -> Coin? {
        coinsResponse?.coins?[indexPath.row]
    }
}
