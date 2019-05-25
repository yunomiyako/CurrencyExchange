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
        label.textAlignment = .center
        return label
    }()
    lazy private var rateLabel : RateLabel = {
        let label = RateLabel()
        label.textAlignment = .center
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
        
        self.layer.borderColor = UIColor.rgba(red: 9, green: 132, blue: 227, alpha: 1).cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 30
    }
    
    // MARK: - Layout subviews -
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutCurrencyPairLabel()
        self.layoutRateLabel()
    }
    
    private func layoutCurrencyPairLabel() {
        let margin : CGFloat = 5
        currencyPairLabel.frame = CGRect(x : margin , y : margin , width: self.frame.width - 2 * margin, height: self.frame.height / 3)
    }
    
    private func layoutRateLabel() {
        let margin : CGFloat = 5
        rateLabel.frame = CGRect(x:  margin , y: self.frame.height / 3 + margin*2, width: self.frame.width - 2*margin, height: self.frame.height / 3 * 2)
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
