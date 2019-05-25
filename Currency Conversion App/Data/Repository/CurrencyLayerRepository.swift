//
//  CurrencyLayerRepository.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation

class CurrencyLayerRepository {
    
    // get CurrencyChangeEntity from API
    func getLiveCurerncyChanges(source: String?, currencies: String? , completion : @escaping (CurrencyChangesEntity) -> ()) {
        CurrencyLayerAPIClient.getLiveCurerncyChanges(source: source, currencies: currencies) { response in
                switch response {
                case .success(let value):
                    completion(value)
                case .error(let error):
                    print("error: \(error)")
                }
        }
    }
    
    // get SupportedCurrenciesEntity from API
    func getSupportedCurrencies(completion : @escaping (SupportedCurrenciesEntity) -> ()) {
        CurrencyLayerAPIClient.getSupportedCurrencies(){ response in
            switch response {
            case .success(let value):
                completion(value)
            case .error(let error):
                print("error: \(error)")
            }
        }
    }
}
