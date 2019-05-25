//
//  CommonUtils.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/25.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation

class CommonUtils {

    static func getNowDate() -> Date {
        let now = Date()
        return now
    }
    
    static func getDiffFromNow(date : Date) -> TimeInterval {
        let now = getNowDate()
        let diff = now.timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate
        return diff
    }
    
}
