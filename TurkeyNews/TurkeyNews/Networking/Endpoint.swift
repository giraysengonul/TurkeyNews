//
//  Endpoint.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import Foundation
/// EndPoint Builder
enum Endpoint{
    
    //fetchGetNewsData
    case fetchGetNewsData(queryItems: [URLQueryItem])
    
    
    /// Constants(baseUrl,..)
    struct Constants {
        static let baseURL = "https://api.collectapi.com"
    }
    
    /// create URL
    var url: URL{
        get{
            switch self{
            case .fetchGetNewsData(_):
                return URL(string: Constants.baseURL)!
            }
        }
    }
    
    /// QueryItems for URL
    var query: [URLQueryItem]{
        get{
            switch self{
            case .fetchGetNewsData(let queryItems):
                return queryItems
            }
        }
    }
    /// Path for URL
    var path: String{
        get{
            switch self{
            case .fetchGetNewsData(_):
                return "/news/getNews"
            }
        }
    }
    
    /// Methot for URL
    var method: String{
        get{
            switch self{
            case .fetchGetNewsData(_):
                return "GET"
            }
        }
    }
    /// Headers for URL
    var headers: [String:String]{
        get{
            //APIKEY Controll
            guard let apikey = getAPIKey() else { return [:] }
            return [
                "content-type":"application/json",
                "authorization": apikey
            ]
        }
    }
    
    /// GET API KEY
       /// - Returns: apikey or nil
       private func getAPIKey() -> String? {
           guard let apiKeyData = KeychainWrapper.shared.load(key: "APIKEY") else {
               return nil
           }
           return String(data: apiKeyData, encoding: .utf8)
       }
    
    
    /// URLRequest Process
    /// - Returns: URLRequest or Nil
    public func requestBuilder() -> URLRequest?{
        guard let urlRequest = APIRequestBuilder.requestBuilder(url: url, methot: method, path: path, queryItems: query, headers: headers) else{
            return nil
        }
        return urlRequest
    }
    
}
