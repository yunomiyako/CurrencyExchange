//
//  APIClient.swift
//  Currency Conversion App
//
//  Created by kitaharamugirou on 2019/05/24.
//  Copyright © 2019 kitaharamugirou. All rights reserved.
//

import Foundation
import Alamofire

public enum Result<T> {
    case success(T)
    case error(Error)
}

public protocol Routable {
    var urlString: String { get }
    var parameters: Parameters { get }
}

open class APIClient {
    typealias CompletionHandler<T> = (Result<T>) -> Void
    
    class func request<T: Decodable>(url: URLConvertible,
                                    method: Alamofire.HTTPMethod,
                                    parameters: Parameters? = nil,
                                    headers: HTTPHeaders? = nil,
                                    completionHandler: CompletionHandler<T>? = nil) {
        Alamofire.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .responseData(completionHandler: { response in
                // debug to look into response value
                //let str = String(data: response.data!, encoding: .utf8)!
                //print(str)
                switch response.result {
                case .success(let value):
                    let decoder = JSONDecoder()
                    do {
                        let entity = try decoder.decode(T.self, from: value)
                        completionHandler?(Result<T>.success(entity))
                    } catch let e {
                        completionHandler?(Result<T>.error(e))
                    }
                case .failure(let error):
                    completionHandler?(Result<T>.error(error))
                }
        })
    }
    
    class func requestRawString(url: URLConvertible,
                                method: Alamofire.HTTPMethod,
                                parameters: Parameters? = nil,
                                headers: HTTPHeaders? = nil,
                                completionHandler: CompletionHandler<String>? = nil) {
        Alamofire.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let value):
                    completionHandler?(Result<String>.success(value))
                case .failure(let error):
                    completionHandler?(Result<String>.error(error))
                }
        }
    }
}
