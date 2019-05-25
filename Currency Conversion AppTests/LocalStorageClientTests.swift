//
//  LocalStorageClientTests.swift
//  Currency Conversion AppTests
//
//  Created by kitaharamugirou on 2019/05/25.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import XCTest
@testable import Currency_Conversion_App

class LocalStorageClientTests: XCTestCase {
    let client = LocalStorageClient()
    let path = "TEST_PATH"
    override func setUp() {
        client.clear(forKey: path)
    }

    override func tearDown() {
        client.clear(forKey: path)
    }

    func testLocalStorageString() {
        let savedValue : String = "str"
        client.set(savedValue, forKey: path)
        let result = client.get(forKey: path) as? String
        XCTAssertNotNil(result)
    }

    func testLocalStorageDate() {
        let savedValue : Date = CommonUtils.getNowDate()
        client.set(savedValue, forKey: path)
        let result = client.get(forKey: path) as? Date
        XCTAssertNotNil(result)
        XCTAssertEqual(result!, savedValue)
    }
}
