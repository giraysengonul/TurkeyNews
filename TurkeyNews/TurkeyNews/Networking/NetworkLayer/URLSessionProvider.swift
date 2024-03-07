//
//  URLSessionProvider.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import Foundation
/// URLSessionProvider
final class URLSessionProvider{
    
    //elements
    private let session: URLSession
    
    /// Init
    /// - Parameter session: URLSession
    init(
        session: URLSession
    )
    {
        self.session = session
    }
    
    /// SessionDataTask Processing
    /// - Parameters:
    ///   - urlRequest: URLRequest
    ///   - completionHandler: Data or Nil , Response or Nil, Error or Nil
    /// - Returns: URLSessionDataTask
    public func sessionDataTask(with urlRequest: URLRequest, completionHandler: @escaping(Data?,URLResponse?,Error?) -> Void ) -> URLSessionDataTask {
        return session.dataTask(with: urlRequest, completionHandler: completionHandler)
    }
}
