//
//  CryptoDetailViewController.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

import UIKit
import Charts
import Kingfisher

final class CryptoDetailViewController: CAViewController {
    
    private lazy var cryptoDetailView: CryptoDetailView = {
        let view = CryptoDetailView()
        view.delegate = self
        return view
    }()
    
    private var viewModel: CryptoDetailViewModel
    
    init(viewModel: CryptoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Coin Detail"
        view = cryptoDetailView
        
        viewModel.delegate = self
        
        cryptoDetailView.coinName = viewModel.coinName
        cryptoDetailView.price = viewModel.price
        cryptoDetailView.isRatePositive = viewModel.isRatePositive
        cryptoDetailView.rate = viewModel.rate
        
        cryptoDetailView.iconImageView.kf.setImage(with: viewModel.iconUrl)
        
        cryptoDetailView.setChartViewDelegate(self)
        
        viewModel.fetchChart()
    }
    
    func setData() {
        let entries = (viewModel.chartResponse?.chart?.map { (metrics) -> ChartDataEntry in
            return ChartDataEntry(x: metrics[0],
                                  y: metrics[1])
        })!
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.liberty()
        set.drawCirclesEnabled = false
        set.lineWidth = 1.7
        set.setColor(.red)
        
        let data = LineChartData(dataSet: set)
        
        cryptoDetailView.lineChartView.data = data
    }
}

// MARK: - CryptoDetailDelegate
extension CryptoDetailViewController: CryptoDetailDelegate {
    func didErrorOccurred(_ error: Error) {
        showAlert(title: "Bir Sorun Oluştu",
                  message: error.localizedDescription)
    }
    
    func didFetchChart() {
        setData()
    }
    
    func didCoinAddedToFavorites() {
        cryptoDetailView.addFavoriteButton.setTitle("Remove From Favorite", for: .normal)
        cryptoDetailView.addFavoriteButton.backgroundColor = .systemRed
    }
}

// MARK: - ChartViewDelegate
extension CryptoDetailViewController: ChartViewDelegate {
    
}

// MARK: - CryptoDetailViewDelegate
extension CryptoDetailViewController: CryptoDetailViewDelegate {
    func cryptoDetailView(_ view: CryptoDetailView, didTapAddFavoriteButton button: UIButton) {
        if button.title(for: .normal) == "Remove From Favorite" {
            print("REMOVED FROM FAVORITE")
            cryptoDetailView.addFavoriteButton.setTitle("Add to Favorite", for: .normal)
            cryptoDetailView.addFavoriteButton.backgroundColor = .systemGreen
        } else {
            viewModel.addFavorite()
        }
    }
}
