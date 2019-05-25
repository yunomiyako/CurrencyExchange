//
//  CurrencyConversionTemplate.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//
import UIKit

protocol CurrencyConversionTemplateDelegate : class {
    func selectedCurrency(viewModel: SupportedCurrencyViewModel)
}

class CurrencyConversionTemplate : UIView {
    // MARK: - Properties -
    lazy private var listExchangeRate : ListExchangeRate = self.createListExchangeRate()
    lazy private var listCurrency : ListCurrency = self.createListCurrency()
    weak var delegate : CurrencyConversionTemplateDelegate? = nil
    
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
        self.addSubview(listExchangeRate)
        self.addSubview(listCurrency)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutListExchangeRate()
        self.layoutListCurrency()
    }
    
    // MARK: - Create subviews -
    private func createListExchangeRate() -> ListExchangeRate {
        let view = ListExchangeRate()
        return view
    }
    
    private func createListCurrency() -> ListCurrency {
        let view = ListCurrency()
        view.delegate = self
        view.backgroundColor = UIColor.clear
        return view
    }
    
    // MARK: - Layout subviews -
    private func layoutListExchangeRate() {
        listExchangeRate.frame.size = CGSize(width: 280, height: 280)
        listExchangeRate.center.x = self.frame.size.width/2
        listExchangeRate.center.y = self.frame.size.height/2
    }
    
    private func layoutListCurrency() {
        listCurrency.frame.size = CGSize(width: self.frame.width, height: self.frame.height)
        listCurrency.frame.origin = CGPoint(x: 0, y: 50)
    }
    
    // MARK: - public functions -
    func setSupportedCurrencies(viewModels : [SupportedCurrencyViewModel]) {
        listCurrency.loadData(viewModels: viewModels)
    }
    
    func setCurrencyChangeRates(viewModels : [CurrencyChangeViewModel]) {
        listExchangeRate.loadData(currencyChangeViewModels: viewModels)
    }
    
}

extension CurrencyConversionTemplate : ListCurrencyDelegate {
    func selectedCurrency(viewModel: SupportedCurrencyViewModel) {
        self.delegate?.selectedCurrency(viewModel: viewModel)
    }
}

