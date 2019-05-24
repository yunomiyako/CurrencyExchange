//
//  CurrencyLayerAPIClient.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation
import Alamofire

final class CurrencyLayerAPIClient: APIClient {
    // MARK: - /
    enum Router: Routable {
        static let host = "https://apilayer.net/api"
        static let access_key : String = "393d7e91eea017841fc9bf9fe784e94f"
        
        var urlString: String {
            return ""
        }
        
        var parameters: Parameters {
            return [:]
        }
        
        // MARK: /live
        enum Live : Routable {
            static let path = "/live"
            
            var urlString: String {
                return Router.host + Live.path
            }
            
            var parameters: Parameters {
                var params: Parameters = [:]
                switch self {
                case let .live(source, currencies):
                    params["access_key"] = access_key
                    if let s = source {
                        params["sorce"] = s
                    }
                    if let c = currencies {
                        params["currencies"] = c
                    }
                }
                return params
            }
            case live(source : String? , currencies : String?)
        }
        
        // MARK: /live
        enum List : Routable {
            static let path = "/list"
            
            var urlString: String {
                return Router.host + List.path
            }
            
            var parameters: Parameters {
                var params: Parameters = [:]
                params["access_key"] = access_key
                return params
            }
        }
    }
}

// MARK: - Interface
extension CurrencyLayerAPIClient {
    typealias GetLiveCurrencyChangesCompletionHandler = (Result<CurrencyChangesEntity>) -> Void
    typealias GetSupportedCurrenciesCompletionHandler = (Result<SupportedCurrenciesEntity>) -> Void
    
    
    /*
     Specify a Source Currency, and you get a exchange rate for each currencies.
     
     **access_key**     [Required] Your API Access Key.
     **source**     [optional] Specify a Source Currency other than the default USD. Supported on the Basic Plan and higher.
     **currencies**     [optional] Specify a comma-separated list of currency codes to limit your API response to specific currencies.
     */
    class func getLiveCurerncyChanges(
                                  source: String? = nil,
                                  currencies: String? = nil,
                                  completionHandler: @escaping GetLiveCurrencyChangesCompletionHandler) {
        let router     = CurrencyLayerAPIClient.Router.Live.live( source: source, currencies: currencies)
        let urlString  = router.urlString
        let parameters = router.parameters
        CurrencyLayerAPIClient.request(url: urlString, method: .get, parameters: parameters , completionHandler: completionHandler)
    }
    
    /*
     get a list of supported currencies
     query : access_key = YOUR_ACCESS_KEY
     */
    class func getSupportedCurrencies(completionHandler : GetSupportedCurrenciesCompletionHandler) {
        
    }
}
