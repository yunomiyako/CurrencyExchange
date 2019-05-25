//
//  SupportedCurrenciesEntityList.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/25.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation

struct SupportedCurrencyViewModel {
    var threeLetter : String //e.g. USD
    var countryName : String //e.g. United States of America
    
    func displayName() -> String {
        return threeLetter + " - " + countryName
    }
}
