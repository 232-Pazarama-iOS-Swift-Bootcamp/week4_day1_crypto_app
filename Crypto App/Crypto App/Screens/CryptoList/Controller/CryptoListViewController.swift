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

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.coinForIndexPath(indexPath)?.name
        return cell
    }
}
