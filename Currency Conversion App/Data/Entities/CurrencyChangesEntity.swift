//
//  CurrencyChangesEntity.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation
struct CurrencyChangesEntity : Codable {
    var success : Bool
    var terms : String
    var privacy : String
    var timestamp : Int
    var source : String
    var quotes : [String : Double]
    
    func convertViewModelList() -> [CurrencyChangeViewModel] {
        var currencyChangeEntityList : [CurrencyChangeViewModel] = []
        let source = self.source
        for q in self.quotes {
            let quote = q.key
            let rate = q.value
            LogDebug("source = \(source) , quote = \(quote) , rate = \(rate)")
            let newElem = CurrencyChangeViewModel(source: source, quote: quote, rate: rate)
            currencyChangeEntityList.append(newElem)
        }
        return currencyChangeEntityList
    }
}

/*
 response format:
 ```
 {
 "success": true,
 "terms": "https://currencylayer.com/terms",
 "privacy": "https://currencylayer.com/privacy",
 "timestamp": 1430401802,
 "source": "USD",
 "quotes": {
 "USDAED": 3.672982,
 "USDAFN": 57.8936,
 "USDALL": 126.1652,
 "USDAMD": 475.306,
 "USDANG": 1.78952,
 "USDAOA": 109.216875,
 "USDARS": 8.901966,
 "USDAUD": 1.269072,
 "USDAWG": 1.792375,
 "USDAZN": 1.04945,
 "USDBAM": 1.757305,
 [...]
 }
 }
 ```
 */
