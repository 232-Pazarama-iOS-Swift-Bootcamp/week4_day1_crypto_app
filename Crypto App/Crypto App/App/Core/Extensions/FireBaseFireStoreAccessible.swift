//
//  FireBaseFireStoreAccessible.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 16.10.2022.
//

import Foundation
import FirebaseFirestore

protocol FireBaseFireStoreAccessible {}

extension FireBaseFireStoreAccessible {
    var db: Firestore {
        Firestore.firestore()
    }
}
