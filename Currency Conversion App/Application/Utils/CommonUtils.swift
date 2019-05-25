//
//  CommonUtils.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/25.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation
func LogDebug(_ message: String,
              function: String = #function,
              file: String = #file,
              line: Int = #line) {
    #if DEBUG
    let cells = file.components(separatedBy: "/")
    let fileName = cells[cells.count-1]
    print("DEBUG: \(message)")
    #elseif DEBUG_STAGING
    print("DEBUG: \(message)")
    #else
    #endif
}

func LogDebugTimer(_ message: String,
                   function: String = #function,
                   file: String = #file,
                   line: Int = #line) {
    #if DEBUG
    let cells = file.components(separatedBy: "/")
    let fileName = cells[cells.count-1]
    print("TIMER: \(message)")
    #elseif DEBUG_STAGING
    print("TIMER: \(message)")
    #else
    #endif
}


func dispatch_after(_ delay_time:Double, block: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay_time, execute:block)
}

func dispatch_async_main(_ block: @escaping () -> ()) {
    DispatchQueue.main.async(execute: block)
}



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
