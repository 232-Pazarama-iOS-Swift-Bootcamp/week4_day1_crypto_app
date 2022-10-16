//
//  CALabel.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 16.10.2022.
//

import UIKit

class CALabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.font = FontFamily.Silkscreen.regular.font(size: 17.0)
    }
}
