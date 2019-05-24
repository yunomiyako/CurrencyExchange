//
//  CurrencyConversionTemplate.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//
import UIKit
class CurrencyConversionTemplate : UIView {
    // MARK: - Properties -
    lazy private var listExchangeRate : ListExchangeRate = self.createListExchangeRate()
    
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutListExchangeRate()
    }
    
    // MARK: - Create subviews -
    private func createListExchangeRate() -> ListExchangeRate {
        let view = ListExchangeRate()
        return view
    }
    
    // MARK: - Layout subviews -
    private func layoutListExchangeRate() {
        listExchangeRate.frame.size = CGSize(width: 280, height: 280)
        listExchangeRate.center.x = self.frame.size.width/2
        listExchangeRate.center.y = self.frame.size.height/2
    }
    
    // MARK: - public functions -
    
    
}
