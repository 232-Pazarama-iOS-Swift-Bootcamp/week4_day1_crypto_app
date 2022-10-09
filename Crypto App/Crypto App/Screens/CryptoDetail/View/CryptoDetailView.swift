//
//  CryptoDetailView.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

import UIKit
import Charts

final class CryptoDetailView: UIView {
    
    // MARK: - Properties
    var coinName: String? {
        didSet {
            coinNameLabel.text = coinName
        }
    }
    
    var price: String? {
        didSet {
            priceLabel.text = price
        }
    }
    
    var rate: String? {
        didSet {
            rateLabel.text = rate
        }
    }
    
    var isRatePositive: Bool = false {
        didSet {
            if isRatePositive {
                rateLabel.textColor = .green
            } else {
                rateLabel.textColor = .red
            }
        }
    }
    
    private lazy var coinNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    private(set) lazy var iconImageView: UIImageView = UIImageView()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0)
        return label
    }()
    
    private lazy var rateLabel: UILabel = UILabel()
    
    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.setTitle("🔔", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 24.0
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setTitle("⚙️", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 24.0
        return button
    }()
    
    private(set) lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.chartDescription.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 1, label: "Index 10")
        llXAxis.lineWidth = 1
        llXAxis.lineDashLengths = [1, 1, 0]
        llXAxis.labelPosition = .rightBottom
        llXAxis.valueFont = .systemFont(ofSize: 10)

        chartView.xAxis.gridLineDashLengths = [1, 1]
        chartView.xAxis.gridLineDashPhase = 0

        let ll1 = ChartLimitLine(limit: 1000, label: "Upper Limit")
        ll1.lineWidth = 1
        ll1.lineDashLengths = [1, 1]
        ll1.labelPosition = .rightTop
        ll1.valueFont = .systemFont(ofSize: 10)

        let ll2 = ChartLimitLine(limit: -1000, label: "Lower Limit")
        ll2.lineWidth = 1
        ll2.lineDashLengths = [1,1]
        ll2.labelPosition = .rightBottom
        ll2.valueFont = .systemFont(ofSize: 10)

        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
        leftAxis.addLimitLine(ll2)
        leftAxis.axisMaximum = 1000
        leftAxis.axisMinimum = -1000
        leftAxis.gridLineDashLengths = [1, 1]
        leftAxis.drawLimitLinesBehindDataEnabled = true

        chartView.rightAxis.enabled = false

        //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
        //[_chartView.viewPortHandler setMaximumScaleX: 2.f];

//        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
//                                   font: .systemFont(ofSize: 12),
//                                   textColor: .white,
//                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
//        marker.chartView = chartView
//        marker.minimumSize = CGSize(width: 80, height: 40)
//        chartView.marker = marker

        chartView.legend.form = .line

        chartView.animate(xAxisDuration: 2.5)
        return chartView
    }()
    
    private lazy var addFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Favorite", for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 24.0
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupCoinNameLabelLayout()
        setupIconImageViewLayout()
        setupPriceLabelLayout()
        setupRateLabelLayout()
        setupSettingsButtonLayout()
        setupAlertButtonLayout()
        setupCoinChartLayout()
        setupAddFavoriteButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupCoinNameLabelLayout() {
        addSubview(coinNameLabel)
        coinNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(20.0)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32.0)
        }
    }
    
    private func setupIconImageViewLayout() {
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(coinNameLabel.snp.trailing).offset(4.0)
            make.centerY.equalTo(coinNameLabel.snp.centerY)
            make.size.equalTo(24.0)
        }
    }
    
    private func setupPriceLabelLayout() {
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(20.0)
            make.top.equalTo(coinNameLabel.snp.bottom).offset(16.0)
        }
    }
    
    private func setupRateLabelLayout() {
        addSubview(rateLabel)
        rateLabel.snp.makeConstraints { make in
            make.leading.equalTo(20.0)
            make.top.equalTo(priceLabel.snp.bottom).offset(16.0)
        }
    }
    
    private func setupSettingsButtonLayout() {
        addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalTo(-20.0)
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.size.equalTo(48.0)
        }
    }
    
    private func setupAlertButtonLayout() {
        addSubview(alertButton)
        alertButton.snp.makeConstraints { make in
            make.trailing.equalTo(settingsButton.snp.leading).offset(-8.0)
            make.centerY.equalTo(settingsButton.snp.centerY)
            make.size.equalTo(48.0)
        }
    }
    
    private func setupCoinChartLayout() {
        addSubview(lineChartView)
        lineChartView.snp.makeConstraints { make in
            make.top.equalTo(rateLabel.snp.bottom).offset(16.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupAddFavoriteButtonLayout() {
        addSubview(addFavoriteButton)
        addFavoriteButton.snp.makeConstraints { make in
            make.top.equalTo(lineChartView.snp.bottom).offset(32.0)
            make.leading.equalTo(20.0)
            make.trailing.equalTo(-20.0)
            make.bottom.equalTo(-32.0)
            make.height.equalTo(48.0)
        }
    }
    
    func setChartViewDelegate(_ delegate: ChartViewDelegate) {
        lineChartView.delegate = delegate
    }
}
