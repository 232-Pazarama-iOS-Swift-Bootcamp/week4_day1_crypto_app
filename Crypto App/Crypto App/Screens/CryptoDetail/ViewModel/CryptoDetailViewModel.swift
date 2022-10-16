//
//  CryptoDetailViewModel.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 9.10.2022.
//

import Foundation
import FirebaseFirestore

@objc
protocol CryptoDetailDelegate: AnyObject {
    @objc optional func didErrorOccurred(_ error: Error)
    @objc optional func didFetchChart()
    @objc optional func didCoinAddedToFavorites()
}

final class CryptoDetailViewModel {
    weak var delegate: CryptoDetailDelegate?
    
    private let db = Firestore.firestore()
    
    private let defaults = UserDefaults.standard
    
    private var coin: Coin
    
    private(set) var chartResponse: ChartResponse? {
        didSet {
            delegate?.didFetchChart?()
        }
    }
    
    var coinName: String? {
        coin.name
    }
    
    var price: String? {
        coin.prettyPrice
    }
    
    var rate: String? {
        coin.prettyChange
    }
    
    var isRatePositive: Bool {
        (coin.priceChange1w ?? .zero) > .zero
    }
    
    var iconUrl: URL {
        coin.iconUrl
    }
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    func fetchChart() {
        guard let id = coin.id else { return }
        provider.request(.chart(id: id, period: "1w")) { result in
            switch result {
            case .failure(let error):
                self.delegate?.didErrorOccurred?(error)
            case .success(let response):
                do {
                    let chartResponse = try JSONDecoder().decode(ChartResponse.self, from: response.data)
                    self.chartResponse = chartResponse
                } catch {
                    self.delegate?.didErrorOccurred?(error)
                }
            }
        }
    }
    
    func addFavorite() {
        guard let id = coin.id,
              let uid = defaults.string(forKey: UserDefaultConstants.uid.rawValue) else {
            return
        }
        
        db.collection("users").document(uid).updateData([
            "favorites": FieldValue.arrayUnion([id])
        ])
        
        delegate?.didCoinAddedToFavorites?()
    }
}
