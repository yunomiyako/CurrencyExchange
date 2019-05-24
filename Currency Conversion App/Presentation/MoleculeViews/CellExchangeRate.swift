//
//  CellExchangeRate.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import UIKit

class CellExchangeRate: UICollectionViewCell {
    static var identifier: String = "CellExchangeRate"
    
    // MARK: - Properties -
    lazy private var currencyPairLabel : CurrencyPairLabel = {
        let label = CurrencyPairLabel()
        return label
    }()
    lazy private var rateLabel : RateLabel = {
        let label = RateLabel()
        return label
    }()
    
    // MARK: - Life cycle events -
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.childInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.childInit()
    }
    
    private func childInit() {
        self.addSubview(currencyPairLabel)
        self.addSubview(rateLabel)
    }
    
    // MARK: - Layout subviews -
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutCurrencyPairLabel()
        self.layoutRateLabel()
    }
    
    private func layoutCurrencyPairLabel() {
        currencyPairLabel.frame = CGRect(x : 0, y : 0, width: self.frame.width, height: self.frame.height / 3)
    }
    
    private func layoutRateLabel() {
        rateLabel.frame = CGRect(x: 0, y: self.frame.height / 3, width: self.frame.width, height: self.frame.height / 3 * 2)
    }
    
    // MARK: - public methods -
    
    func loadViewModel(viewModel : CurrencyChangeViewModel) {
        let source = viewModel.source
        let quote = viewModel.quote
        let rate = viewModel.rate
        
        self.setCurrencyPair(sourceCurrency: source, quoteCurrency: quote)
        self.setRate(rate: rate)
    }
    
    
    // MARK: - private methods -
    private func setCurrencyPair(sourceCurrency: String, quoteCurrency: String) {
        currencyPairLabel.setLabelText(sourceCurrency: sourceCurrency, quoteCurrency: quoteCurrency)
    }
    
    private func setRate(rate : Double) {
        rateLabel.setLabelText(rate: rate)
    }
    
}
