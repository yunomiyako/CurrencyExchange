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
    
    func getLiveCurerncyChanges(source: String?, currencies: String?){
        self.rep.getLiveCurerncyChanges(source: source, currencies: currencies)
    }
}
