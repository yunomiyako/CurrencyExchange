//
//  LocalStorageClient.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/25.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation
class LocalStorageClient {
    //singleton
    static let sharedInstance = LocalStorageClient()
    private init() {
    }
    
    /*
     - parameter content:content to save, forKey: path for the content
     */
    final func set (_ content:Any, forKey:String) {
        UserDefaults.standard.set(content, forKey: forKey)
    }
    
    final func get(forKey:String) -> Any? {
        return UserDefaults.standard.object(forKey:forKey)
    }

    final func clear(forKey:String) {
        UserDefaults.standard.removeObject(forKey: forKey)
    }
    
}
