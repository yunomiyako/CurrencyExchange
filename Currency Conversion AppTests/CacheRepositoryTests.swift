//
//  CacheRepositoryTests.swift
//  Currency Conversion AppTests
//
//  Created by kitaharamugirou on 2019/05/25.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import XCTest
@testable import Currency_Conversion_App

class LocalStorageClientMock : LocalStorageClient {
    var setCalled = false
    override func set (_ content:Any, forKey:String) {
        setCalled = true
    }
}

class CacheRepositoryTests: XCTestCase {
    let path = "TEST"
    var rep = CacheAPIRepository()

    override func setUp() {
        rep = CacheAPIRepository()
        rep.clearAllCache()
    }

    override func tearDown() {
        rep.clearAllCache()
    }

    //maxAge is 100sec so cache must not be dead
    func testSaveDate() {
        rep.saveDate(path: path)
        let result = rep.IsCacheDead(path: path, maxAge: 100)
        XCTAssertFalse(result)
    }
    
    //maxAge is -1sec so cache must be dead
    func testSaveDate2() {
        rep.saveDate(path: path)
        let result = rep.IsCacheDead(path: path, maxAge: -1)
        XCTAssertTrue(result)
    }

    /*
     DO : set testValue into cache
     EXPECT : localStorageClient's set must be called
     */
    func testSetSupportedCurrencies() {
        let clientMock = LocalStorageClientMock()
        rep.injectLocalStorageClient(localStorageClient: clientMock)
        
        let testValue = SupportedCurrenciesEntity(success: true, terms: "", privacy: "", currencies: [:])
        rep.setSupportedCurrencies(value: testValue)
        XCTAssertTrue(clientMock.setCalled)
    }
    
    /*
     DO : set testValue into cache and get it immediately
     EXPECT : value from cache must not be nil and be same as input value
     */
    func testGetSupportedCurrencies() {
        let testValue = SupportedCurrenciesEntity(success: true, terms: "terms test", privacy: "", currencies: [:])
        rep.setSupportedCurrencies(value: testValue)
        
        let result = rep.getSupportedCurrencies(maxAge: 100)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.terms, testValue.terms)
    }
}
