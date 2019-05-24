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
    
    func getLiveCurerncyChanges(source: String?, currencies: String? , completion : @escaping ([CurrencyChangeViewModel]) -> ()){
        self.rep.getLiveCurerncyChanges(source: source, currencies: currencies) { res in
            let viewModels = res.convertViewModelList()
            completion(viewModels)
        }
    }
    
    func getSupportedCurrencies(completion : @escaping ([SupportedCurrencyViewModel]) -> ()) {
        self.rep.getSupportedCurrencies() { res in
            let viewModels = res.convertViewModelList()
            completion(viewModels)
        }
    }
}
