//
//  CryptoDetailViewController.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

import UIKit
import Charts

final class CryptoDetailViewController: UIViewController {

    private let cryptoView = CryptoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Coin Detail"
        view = cryptoView
    }
}
