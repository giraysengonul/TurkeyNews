//
//  WNetworkLogger.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import Foundation
/// WNetworkLogger Process
final class NetworkLogger {
    /// Singleton
    static let shared = NetworkLogger()
    
    /// Init Process
    private init(){}
    
    /// URLRequest Log Process
    /// - Parameter request: URLRequest
     public func log(request: URLRequest) {
         print("--> Request URL: \(request.url?.absoluteString ?? "")")
         print("--> Request Method: \(request.httpMethod ?? "")")
         if let headers = request.allHTTPHeaderFields {
             print("--> Request Headers: \(headers)")
         }
         if let body = request.httpBody {
             print("--> Request Body: \(String(data: body, encoding: .utf8) ?? "")")
         }
    }
    
    /// URLResPonse Process
    /// - Parameters:
    ///   - response: URLResponse
    ///   - data: Data
    public func log(response: URLResponse?, data: Data?) {
        if let httpResponse = response as? HTTPURLResponse {
            print("Response Status Code: \(httpResponse.statusCode)")
        }
        if let responseData = data {
            print("Response Data: \(String(data: responseData, encoding: .utf8) ?? "")")
        }
    }
    
    /// HTTPURLResponse Processing
    /// - Parameters:
    ///   - response: HTTPURLResponse
    ///   - data: data
    public func log(httpResponse: HTTPURLResponse?, data: Data?) {
           if let response = httpResponse {
               print("<-- Response Status Code: \(response.statusCode)")
           }
           if let headers = httpResponse?.allHeaderFields as? [String: String] {
               print("<-- Response Headers: \(headers)")
           }
           if let responseData = data, let responseBody = String(data: responseData, encoding: .utf8) {
               print("<-- Response Body: \(responseBody)")
           }
       }
}
