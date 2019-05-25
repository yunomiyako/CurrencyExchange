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

    func testSaveDate() {
        rep.saveDate(path: path)
        let result = rep.IsCacheDead(path: path, maxAge: 100)
        XCTAssertFalse(result)
    }
    
    func testSaveDate2() {
        rep.saveDate(path: path)
        let result = rep.IsCacheDead(path: path, maxAge: -1)
        XCTAssertTrue(result)
    }

    func testSetSupportedCurrencies() {
        let clientMock = LocalStorageClientMock()
        rep.injectLocalStorageClient(localStorageClient: clientMock)
        
        let testValue = SupportedCurrenciesEntity(success: true, terms: "", privacy: "", currencies: [:])
        rep.setSupportedCurrencies(value: testValue)
        XCTAssertTrue(clientMock.setCalled)
    }
    
    func testGetSupportedCurrencies() {
        let testValue = SupportedCurrenciesEntity(success: true, terms: "terms test", privacy: "", currencies: [:])
        rep.setSupportedCurrencies(value: testValue)
        
        let result = rep.getSupportedCurrencies(maxAge: 100)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.terms, testValue.terms)
    }
}
