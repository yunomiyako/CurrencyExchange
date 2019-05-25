//
//  CurrencyLayerUseCase.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation
class CurrencyLayerUseCase {
    private let rep = CurrencyLayerRepository()
    private let cache_rep = CacheAPIRepository()
    
    func getLiveCurerncyChanges(source: String, currencies: String? , completion : @escaping ([CurrencyChangeViewModel]) -> ()){
        
        //if cache is found , return it
        let cache = self.cache_rep.getLiveCurerncyChanges(source: source, currencies: currencies)
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
    
    func getSupportedCurrencies(completion : @escaping ([SupportedCurrencyViewModel]) -> ()) {
        //if cache is found , return it
        let cache = self.cache_rep.getSupportedCurrencies()
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
}
