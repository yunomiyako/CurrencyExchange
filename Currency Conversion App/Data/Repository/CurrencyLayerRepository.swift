//
//  CurrencyLayerRepository.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation

class CurrencyLayerRepository {
    
    func getLiveCurerncyChanges(source: String?, currencies: String?) {
            CurrencyLayerAPIClient.getLiveCurerncyChanges(source: source, currencies: currencies) { [weak self] response in
                switch response {
                case .success(let value):
                    guard let weakSelf = self else {
                        return
                    }
                    
                case .error(let error):
                    print("error: \(error)")
                }
            
        }
    }
}
