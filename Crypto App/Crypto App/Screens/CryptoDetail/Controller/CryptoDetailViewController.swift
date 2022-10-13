//
//  CryptoDetailViewController.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

import UIKit
import Charts
import Kingfisher

final class CryptoDetailViewController: UIViewController {
    
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
    
    func setup(_ dataSet: LineChartDataSet) {
        if dataSet.isDrawLineWithGradientEnabled {
            dataSet.lineDashLengths = nil
            dataSet.highlightLineDashLengths = nil
            dataSet.setColors(.black, .red, .white)
            dataSet.setCircleColor(.black)
            dataSet.gradientPositions = [0, 40, 100]
            dataSet.lineWidth = 1
            dataSet.circleRadius = 3
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = nil
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
        } else {
            dataSet.lineDashLengths = [5, 2.5]
            dataSet.highlightLineDashLengths = [5, 2.5]
            dataSet.setColor(.black)
            dataSet.setCircleColor(.black)
            dataSet.gradientPositions = nil
            dataSet.lineWidth = 1
            dataSet.circleRadius = 3
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = [5, 2.5]
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
        }
    }
    
    func setData() {
        let entries = (viewModel.chartResponse?.chart?.map { (metrics) -> ChartDataEntry in
            return ChartDataEntry(x: metrics[0], y: metrics[1])
        })!
        
        let set = LineChartDataSet(entries: entries)
        let data = LineChartData(dataSet: set)
        cryptoDetailView.lineChartView.data = data
        
        set.colors = ChartColorTemplates.liberty()
        set.drawCirclesEnabled = false
        set.lineWidth = 1.7
        set.setColor(.red)
    }
}

// MARK: - CryptoDetailDelegate
extension CryptoDetailViewController: CryptoDetailDelegate {
    func didErrorOccurred(_ error: Error) {
        print(error.localizedDescription)
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
