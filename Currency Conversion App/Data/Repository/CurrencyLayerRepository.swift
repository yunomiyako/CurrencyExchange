//
//  CurrencyLayerRepository.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation

class CurrencyLayerRepository {
    
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
}
