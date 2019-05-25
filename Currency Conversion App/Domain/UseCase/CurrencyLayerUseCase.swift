//
//  CurrencyLayerUseCase.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation
class CurrencyLayerUseCase {
    private var rep = CurrencyLayerRepository()
    private var cache_rep = CacheAPIRepository()
    
    
    /*
     Get exchange rate of specified source and other currency.
     To secure the bandwidth, the obtained result is stored in the cache and used for 30 minutes.
     If currencies is nil, it gets all currenciy pairs. If you want to specify it, pass it in comma separated.
     */
    func getLiveCurerncyChanges(source: String, currencies: String? , completion : @escaping ([CurrencyChangeViewModel]) -> ()){
        
        //if cache is found , return it
        let maxAge : Double = 30 * 60 //30min = 30*60s
        let cache = self.cache_rep.getLiveCurerncyChanges(source: source, currencies: currencies, maxAge: maxAge)
        if let c = cache {
            let viewModels = c.convertViewModelList()
            completion(viewModels)
            return
        }
        
        //if cache is not found , request api
        self.rep.getLiveCurerncyChanges(source: source, currencies: currencies) { res in
            self.cache_rep.setLiveCurrencyChanges(source: source, currencies: currencies, value: res)
            let viewModels = res.convertViewModelList()
            completion(viewModels)
        }
    }
    
    /*
     Get a list of currencies supported by ExchangeLayer
     */
    func getSupportedCurrencies(completion : @escaping ([SupportedCurrencyViewModel]) -> ()) {
        //if cache is found , return it
        let maxAge : Double = 30 * 60 //30min = 30*60s
        let cache = self.cache_rep.getSupportedCurrencies(maxAge: maxAge)
        if let c = cache {
            let viewModels = c.convertViewModelList()
            completion(viewModels)
            return
        }
        
        //if cache is not found , request api
        self.rep.getSupportedCurrencies() { res in
            self.cache_rep.setSupportedCurrencies(value: res)
            let viewModels = res.convertViewModelList()
            completion(viewModels)
        }
    }
    
    // MARK - for test code -
    func injectApiRepository(rep : CurrencyLayerRepository){
        self.rep = rep
    }
    
    func injectCacheRepository(rep : CacheAPIRepository) {
        self.cache_rep = rep
    }
    
    func clearAllLocalCache() {
        self.cache_rep.clearAllCache()
    }
    
    func updateCacheDate(date : Date  , path : String) {
        self.cache_rep.saveDate(date: date, path: path)
    }
    
}
