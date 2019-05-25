//
//  CurrencyPairLabel.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import UIKit

class CurrencyPairLabel: UILabel {
    // MARK: - Life cycle events -
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func setLabelText(sourceCurrency : String , targetCurrency : String) {
        self.text = "\(sourceCurrency) / \(targetCurrency)"
    }
}
