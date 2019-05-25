//
//  CacheAPIRepository.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/25.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation
class CacheAPIRepository {
    private var localStorageClient = LocalStorageClient.sharedInstance
    
    // MARK - path for value -
    func pathForLiveCurrencyChanges(source: String , currencies: String?) -> String {
        var path = source
        if let c = currencies {
            path += " - " + c
        }
        return LocalStorageKeys.LIVE_CURRENCY_CHANGE + path
    }
    
    // MARK - cache control -
    func IsCacheDead(path : String , maxAge : Double?) -> Bool {
        guard let _maxAge = maxAge else {return true}
        let _savedTime = localStorageClient.get(forKey: LocalStorageKeys.PREFIX_TIME + path) as? Date
        guard let savedTime = _savedTime else { return true }
        let age = CommonUtils.getDiffFromNow(date: savedTime)
        if age.isLess(than: _maxAge) {
            return false
        } else {
            return true
        }
    }
    
    func saveDate(path : String) {
        let savedTime = CommonUtils.getNowDate()
        saveDate(date: savedTime, path: path)
    }
    
    func saveDate(date : Date , path : String) {
        localStorageClient.set(date , forKey: LocalStorageKeys.PREFIX_TIME + path)
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
        let path = LocalStorageKeys.SUPPORTED_CURRENCY_PATH
        if IsCacheDead(path: path, maxAge: maxAge) {
            return nil
        }
        
        //json decode
        guard let jsonData = localStorageClient.get(forKey: path) as? Data else {
            return nil
        }
        
        let entity = try? JSONDecoder().decode(SupportedCurrenciesEntity.self, from: jsonData)
        return entity
    }
    
    func setSupportedCurrencies(value : SupportedCurrenciesEntity) {
        let path = LocalStorageKeys.SUPPORTED_CURRENCY_PATH
        //json encode
        if let json = try? JSONEncoder().encode(value) {
            let jsonStr = String(bytes: json, encoding: .utf8)!
            localStorageClient.set(json, forKey: path)
            saveDate(path: path)
        }
    }
    
    func clearAllCache() {
        localStorageClient.clearAll()
    }
    
    // MARK - for test code -
    func injectLocalStorageClient(localStorageClient : LocalStorageClient) {
        self.localStorageClient = localStorageClient
    }
    
}
