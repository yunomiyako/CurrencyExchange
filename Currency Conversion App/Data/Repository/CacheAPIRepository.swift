//
//  CacheAPIRepository.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/25.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation
class CacheAPIRepository {
    private let localStorageClient = LocalStorageClient.sharedInstance
    
    // MARK - path for value -
    func pathForLiveCurrencyChanges(source: String , currencies: String?) -> String {
        var path = source
        if let c = currencies {
            path += " - " + c
        }
        return path
    }
    
    private let SUPPORTED_CURRENCY_PATH = "SUPPORTED_CURRENCY_PATH"
    
    // MARK - get and set cache functions -
    func getLiveCurerncyChanges(source: String , currencies: String?) -> CurrencyChangesEntity? {
        let path = pathForLiveCurrencyChanges(source: source, currencies: currencies)
        let rst = localStorageClient.get(forKey: path) as? CurrencyChangesEntity
        return rst
    }
    
    func setLiveCurrencyChanges(source: String , currencies: String? , value : CurrencyChangesEntity) {
        let path = pathForLiveCurrencyChanges(source: source, currencies: currencies)
        localStorageClient.set(value, forKey: path)
    }
    
    func getSupportedCurrencies() -> SupportedCurrenciesEntity? {
        let path = SUPPORTED_CURRENCY_PATH
        let rst = localStorageClient.get(forKey: path) as? SupportedCurrenciesEntity
        return rst
    }
    
    func setSupportedCurrencies(value : SupportedCurrenciesEntity) {
        let path = SUPPORTED_CURRENCY_PATH
        localStorageClient.set(value, forKey: path)
    }
}
