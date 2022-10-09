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
    
    private let cryptoDetailView = CryptoDetailView()
    
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
        let values = (viewModel.chartResponse?.chart?.enumerated().map { (index, metrics) -> ChartDataEntry in
            return ChartDataEntry(x: Double(index), y: metrics[1], icon: nil)
        })!

        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        set1.drawIconsEnabled = false
        setup(set1)

        let value = ChartDataEntry(x: Double(3), y: 3)
        set1.addEntryOrdered(value)
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        set1.fillAlpha = 1
        set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set1.drawFilledEnabled = true

        let data = LineChartData(dataSet: set1)

        cryptoDetailView.lineChartView.data = data
        cryptoDetailView.lineChartView.animate(xAxisDuration: 2.5)
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
}

// MARK: - ChartViewDelegate
extension CryptoDetailViewController: ChartViewDelegate {
    
}
