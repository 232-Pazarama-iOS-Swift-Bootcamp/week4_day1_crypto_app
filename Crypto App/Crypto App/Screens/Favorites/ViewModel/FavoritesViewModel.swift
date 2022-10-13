//
//  FavoritesViewModel.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 13.10.2022.
//

import Foundation
import FirebaseFirestore

final class FavoritesViewModel {
    
    private let db = Firestore.firestore()
    
    private var coins: [Coin]?
    
    var numberOfRows: Int {
        coins?.count ?? .zero
    }
    
    func coinForIndexPath(_ indexPath: IndexPath) -> Coin? {
        coins?[indexPath.row]
    }
    
    func fetchFavorites(_ completion: @escaping (Error?) -> Void) {
        db.collection("coins").getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(err)
            } else {
                self.coins = querySnapshot!.documents.map { document in
                    Coin(from: document.data())
                }
                completion(nil)
            }
        }
    }
}
