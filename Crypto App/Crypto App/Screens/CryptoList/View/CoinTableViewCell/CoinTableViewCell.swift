//
//  CoinTableViewCell.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 8.10.2022.
//

import UIKit

final class CoinTableViewCell: UITableViewCell {
    
    var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            titleLabel.text
        }
    }
    
    var price: String? {
        didSet {
            priceLabel.text = price
        }
    }
    
    @IBOutlet private(set) weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: CALabel!
    @IBOutlet private weak var priceLabel: CALabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        priceLabel.font = FontFamily.Silkscreen.bold.font(size: 17.0)
    }
}
