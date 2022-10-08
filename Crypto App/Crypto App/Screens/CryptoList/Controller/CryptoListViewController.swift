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

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableViewDelegate
extension CryptoListViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension CryptoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Cell - \(indexPath.row)"
        return cell
    }
}
