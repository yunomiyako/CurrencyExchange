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
    
    private let PREFIX_TIME = "PREFIX_TIME_"
    
    // MARK - cache control -
    func IsCacheDead(path : String , maxAge : Double?) -> Bool {
        guard let _maxAge = maxAge else {return true}
        let _savedTime = localStorageClient.get(forKey: PREFIX_TIME + path) as? Date
        guard let savedTime = _savedTime else { return true }
        let age = CommonUtils.getDiffFromNow(date: savedTime)
        if age.isLess(than: _maxAge) {
            return true
        } else {
            return false
        }
    }
    
    func saveDate(path : String) {
        let savedTime = CommonUtils.getNowDate()
        localStorageClient.set(savedTime , forKey: PREFIX_TIME + path)
    }
    
    // MARK - get and set cache functions -
    func getLiveCurerncyChanges(source: String , currencies: String? , maxAge : Double?) -> CurrencyChangesEntity? {
        let path = pathForLiveCurrencyChanges(source: source, currencies: currencies)
        let json = localStorageClient.get(forKey: path) as? String
        if IsCacheDead(path: path, maxAge: maxAge) {
            return nil
        }
        
        //json decode
        guard let data = json?.data(using: .utf8) else {return nil}
        let entity = try? JSONDecoder().decode(CurrencyChangesEntity.self, from: data)
        return entity
    }
    
    func setLiveCurrencyChanges(source: String , currencies: String? , value : CurrencyChangesEntity) {
        let path = pathForLiveCurrencyChanges(source: source, currencies: currencies)
        
        //json encode
        if let json = try? JSONEncoder().encode(value) {
            localStorageClient.set(json, forKey: path)
            saveDate(path: path)
        }
    }
    
    func getSupportedCurrencies(maxAge : Double) -> SupportedCurrenciesEntity? {
        let path = SUPPORTED_CURRENCY_PATH
        let json = localStorageClient.get(forKey: path) as? String
        if IsCacheDead(path: path, maxAge: maxAge) {
            return nil
        }
        
        //json decode
        guard let data = json?.data(using: .utf8) else {return nil}
        let entity = try? JSONDecoder().decode(SupportedCurrenciesEntity.self, from: data)
        return entity
    }
    
    func setSupportedCurrencies(value : SupportedCurrenciesEntity) {
        let path = SUPPORTED_CURRENCY_PATH
        //json encode
        if let json = try? JSONEncoder().encode(value) {
            localStorageClient.set(json, forKey: path)
            saveDate(path: path)
        }
    }
}
