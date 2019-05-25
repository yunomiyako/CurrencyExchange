//
//  Currency_Conversion_AppTests.swift
//  Currency Conversion AppTests
//
//  Created by kitaharamugirou on 2019/05/25.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import XCTest
@testable import Currency_Conversion_App

class ApiRepositoryMock : CurrencyLayerRepository {
    var apiRepositoryCalled = false
    override func getSupportedCurrencies(completion: @escaping (SupportedCurrenciesEntity) -> ()) {
        self.apiRepositoryCalled = true
    }
}



class Currency_Conversion_AppTests: XCTestCase {
    var usecase : CurrencyLayerUseCase = CurrencyLayerUseCase()
    
    override func setUp() {
        usecase = CurrencyLayerUseCase()
        usecase.clearAllLocalCache()
    }

    override func tearDown() {
        usecase.clearAllLocalCache()
    }

    
    /*
     DO: call getSupportedCurrencies once.
     EXPECT : API will be called
     */
    func testCallOnceFirstTime() {
        let apiRepositoryMock = ApiRepositoryMock()
        usecase.injectApiRepository(rep : apiRepositoryMock)
        usecase.getSupportedCurrencies(completion: {_ in})
        XCTAssertEqual(apiRepositoryMock.apiRepositoryCalled , true)
    }
    
    /*
     DO: call getSupportedCurrencies twice.
     EXPECT : API will be called at first time, but at second time API will not be called
     */
    func testCallTwice() {
        let apiRepositoryMock = ApiRepositoryMock()
        usecase.injectApiRepository(rep : apiRepositoryMock)
        
        usecase.getSupportedCurrencies(completion: {_ in
            apiRepositoryMock.apiRepositoryCalled = false
            self.usecase.getSupportedCurrencies(completion: {_ in
                XCTAssertEqual(apiRepositoryMock.apiRepositoryCalled , false)
            })
        })
    }
    
    /*
     DO: call getSupportedCurrencies twice. update cache date into 35 minutes before from now
     EXPECT : API will be called at first time, and will be called at second time too.
     */
    func testCallTwiceAfter30min() {
        let apiRepositoryMock = ApiRepositoryMock()
        usecase.injectApiRepository(rep : apiRepositoryMock)
        
        usecase.getSupportedCurrencies(completion: {_ in
            apiRepositoryMock.apiRepositoryCalled = false
            let oldDate = CommonUtils.getNowDate().addingTimeInterval(-35 * 60)
            self.usecase.updateCacheDate(date: oldDate, path : LocalStorageKeys.SUPPORTED_CURRENCY_PATH)
            self.usecase.getSupportedCurrencies(completion: {_ in
                XCTAssertEqual(apiRepositoryMock.apiRepositoryCalled , true)
            })
        })
    }
    
}
