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
    init() {
    }
    
    /*
     - parameter content:content to save, forKey: path for the content
     */
    func set(_ content:Any, forKey:String) {
        UserDefaults.standard.set(content, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    func get(forKey:String) -> Any? {
        let result = UserDefaults.standard.object(forKey:forKey)
        return result
    }

    func clear(forKey:String) {
        UserDefaults.standard.removeObject(forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
    
}
