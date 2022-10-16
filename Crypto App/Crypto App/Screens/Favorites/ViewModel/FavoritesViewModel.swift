//
//  FavoritesViewModel.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 13.10.2022.
//

import Foundation

final class FavoritesViewModel: CAViewModel {
    
    private var coins = [Coin]()
    
    var numberOfRows: Int {
        coins.count
    }
    
    func coinForIndexPath(_ indexPath: IndexPath) -> Coin? {
        coins[indexPath.row]
    }
    
    func fetchFavorites(_ completion: @escaping (Error?) -> Void) {
        
        coins = []
        
        guard let uid = uid else {
            return
        }
        
        db.collection("users").document(uid).getDocument() { (querySnapshot, err) in
            guard let data = querySnapshot?.data() else {
                return
            }
            let user = User(from: data)
            
            user.favorites?.forEach({ coinId in
                self.db.collection("coins").document(coinId).getDocument { (querySnapshot, err) in
                    if let err = err {
                        completion(err)
                    } else {
                        guard let data = querySnapshot?.data() else {
                            return
                        }
                        let coin = Coin(from: data)
                        self.coins.append(coin)
                        completion(nil)
                    }
                }
            })
        }
    }
}
