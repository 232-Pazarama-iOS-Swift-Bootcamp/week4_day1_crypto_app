//
//  FavoritesViewController.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 13.10.2022.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    private let viewModel: FavoritesViewModel

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Init
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CoinTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        viewModel.fetchFavorites { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.tableView.reloadData()
            }
        }
    }

}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
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
