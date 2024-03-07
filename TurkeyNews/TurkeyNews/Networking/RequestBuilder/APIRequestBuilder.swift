//
//  APIRequestBuilder.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import Foundation

/// API Request Builder
final class APIRequestBuilder{
    
    /// Init
    private init() {}
    
    /// Request Builder Process
    /// - Parameter url: url
    /// - Parameter methot: methot(GET,POST,or..)
    /// - Parameter headers: header value
    /// - Returns: URLRequest
    static func requestBuilder(url: URL, methot: String, path: String, queryItems: [URLQueryItem] ,headers: [String:String]) -> URLRequest?{
        guard let componenURL = URLComponents(url: url.appendingPathComponent(path).appending(queryItems: queryItems), resolvingAgainstBaseURL: true) else{
            return nil
        }
        guard let url = componenURL.url else {
            print("url error")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = methot
        request.allHTTPHeaderFields = headers
        return request
        
    }
}
