//
//  CryptoView.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

import UIKit
import Charts

final class CryptoView: UIView {
    
    // MARK: - Properties
    private lazy var coinNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Name Label"
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price Label"
        return label
    }()
    
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.text = "Rate Label"
        return label
    }()
    
    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Alert", for: .normal)
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Settings", for: .normal)
        return button
    }()
    
    private lazy var coinChart: LineChartView = {
        let chart = LineChartView()
        chart.backgroundColor = .gray
        return chart
    }()
    
    private lazy var addFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Favorite", for: .normal)
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
            make.size.equalTo(32.0)
        }
    }
    
    private func setupPriceLabelLayout() {
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(20.0)
            make.top.equalTo(coinNameLabel.snp.bottom).offset(8.0)
        }
    }
    
    private func setupRateLabelLayout() {
        addSubview(rateLabel)
        rateLabel.snp.makeConstraints { make in
            make.leading.equalTo(20.0)
            make.top.equalTo(priceLabel.snp.bottom).offset(8.0)
        }
    }
    
    private func setupSettingsButtonLayout() {
        addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalTo(-20.0)
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.size.equalTo(64.0)
        }
    }
    
    private func setupAlertButtonLayout() {
        addSubview(alertButton)
        alertButton.snp.makeConstraints { make in
            make.trailing.equalTo(settingsButton.snp.leading).offset(-8.0)
            make.centerY.equalTo(settingsButton.snp.centerY)
            make.size.equalTo(64.0)
        }
    }
    
    private func setupCoinChartLayout() {
        addSubview(coinChart)
        coinChart.snp.makeConstraints { make in
            make.top.equalTo(rateLabel.snp.bottom).offset(16.0)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupAddFavoriteButtonLayout() {
        addSubview(addFavoriteButton)
        addFavoriteButton.snp.makeConstraints { make in
            make.leading.equalTo(20.0)
            make.trailing.equalTo(-20.0)
            make.bottom.equalTo(32.0)
            make.height.equalTo(48.0)
        }
    }
}
