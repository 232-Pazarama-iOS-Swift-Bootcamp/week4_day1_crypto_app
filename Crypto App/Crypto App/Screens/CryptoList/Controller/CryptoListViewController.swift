//
//  CryptoListViewController.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

// Referance Counter
// table: 1
// view: 1

import UIKit
import Kingfisher

final class CryptoListViewController: UIViewController  {
    private var viewModel: CryptoListViewModel

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Init
    init(viewModel: CryptoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Coins"

        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "CoinTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        viewModel.fetchCoins()
        
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchCoins:
                self.tableView.reloadData()
            case .didErrorOccurred(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension CryptoListViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension CryptoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CoinTableViewCell
        guard let coin = viewModel.coinForIndexPath(indexPath) else {
            fatalError("coin not found.")
        }
        
        cell.title = coin.name
        cell.price = coin.prettyPrice
        cell.imageView?.kf.setImage(with: coin.iconUrl) { _ in
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        return cell
    }
}
