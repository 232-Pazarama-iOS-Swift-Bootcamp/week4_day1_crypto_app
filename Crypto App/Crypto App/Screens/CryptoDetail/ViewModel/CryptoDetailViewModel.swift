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
        guard let data = coin.dictionary else {
            return
        }
        db.collection("coins").addDocument(data: data) { err in
            if let err = err {
                self.delegate?.didErrorOccurred?(err)
            } else {
                self.delegate?.didCoinAddedToFavorites?()
            }
        }
    }
}
