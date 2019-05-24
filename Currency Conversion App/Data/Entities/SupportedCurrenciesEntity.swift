//
//  SupportedCurrenciesEntity.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/25.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation
struct SupportedCurrenciesEntity : Decodable {
    var success : Bool
    var terms : String
    var privacy : String
    var currencies : [String : String]
    
    func convertViewModelList() -> [SupportedCurrencyViewModel] {
        var supportedCurrenciesEntityList : [SupportedCurrencyViewModel] = []
        for c in self.currencies {
            let threeLetter = c.key
            let countryName = c.value
            let newElem = SupportedCurrencyViewModel(threeLetter: threeLetter , countryName: countryName)
            supportedCurrenciesEntityList.append(newElem)
        }
        return supportedCurrenciesEntityList
    }
}

/*
 response format:
 {
 "success": true,
 "terms": "https://currencylayer.com/terms",
 "privacy": "https://currencylayer.com/privacy",
 "currencies": {
 "AED": "United Arab Emirates Dirham",
 "AFN": "Afghan Afghani",
 "ALL": "Albanian Lek",
 "AMD": "Armenian Dram",
 "ANG": "Netherlands Antillean Guilder",
 [...]
 }
 }
 */
