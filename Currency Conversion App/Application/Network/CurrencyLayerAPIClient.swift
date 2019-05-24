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
                case let .live(access_key, source, currencies):
                    params["q"] = access_key
                    if let s = source {
                        params["sorce"] = s
                    }
                    if let c = currencies {
                        params["currencies"] = c
                    }
                }
                return params
            }
            case live(access_key : String , source : String? , currencies : String?)
        }
    }
}

// MARK: - Interface
extension CurrencyLayerAPIClient {
    typealias GetLiveCurrencyChangesCompletionHandler = (Result<CurrencyChangesEntity>) -> Void
    typealias GetRepositoryReadmeCompletionHandler = (Result<String>) -> Void
    
    
    /*
     **access_key**     [Required] Your API Access Key.
     **source**     [optional] Specify a Source Currency other than the default USD. Supported on the Basic Plan and higher.
     **currencies**     [optional] Specify a comma-separated list of currency codes to limit your API response to specific currencies.
     */
    class func getLiveCurerncyChanges(
                                  access_key: String,
                                  source: String? = nil,
                                  currencies: String? = nil,
                                  completionHandler: GetLiveCurrencyChangesCompletionHandler? = nil) {
        let router     = CurrencyLayerAPIClient.Router.Live.live(access_key: access_key, source: source, currencies: currencies)
        let urlString  = router.urlString
        let parameters = router.parameters
        
        CurrencyLayerAPIClient.request(url: urlString, method: .get, parameters: parameters, completionHandler: completionHandler)
    }
    
}
