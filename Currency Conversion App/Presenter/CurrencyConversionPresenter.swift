//
//  CurrencyExchangePresenter.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//
import Foundation

protocol CurrencyConversionPresenterInput {
    func endLoadingCurrencyChangeViewModel(viewModels : [CurrencyChangeViewModel])
    func endLoadingSupportedCurrencies(viewModels: [SupportedCurrencyViewModel])
}

class CurrencyConversionPresenter {
    private let usecase = CurrencyLayerUseCase()
    private let viewController : CurrencyConversionPresenterInput?
    
    init(viewController : CurrencyConversionPresenterInput) {
        self.viewController = viewController
    }
    
    func loadSupportedCurrencies() {
        self.usecase.getSupportedCurrencies() { viewModels in
            self.viewController?.endLoadingSupportedCurrencies(viewModels: viewModels)
        }
        
    }
    
    func selectedCertainCurrency(currency : SupportedCurrencyViewModel) {
        //CHECK : it now get all possible currencies' rate because currencies is now nil
        let threeLetter = currency.threeLetter
        self.usecase.getLiveCurerncyChanges(source: threeLetter, currencies: nil) { viewModels in
            self.viewController?.endLoadingCurrencyChangeViewModel(viewModels: viewModels)
        }
    }

}
