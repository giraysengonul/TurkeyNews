//
//  MockURLProtocol.swift
//  TurkeyNewsTests
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var data: Data?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        
        if let data = MockURLProtocol.data{
            let httpURLResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            self.client?.urlProtocol(self, didReceive: httpURLResponse,cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: data)
            self.client?.urlProtocolDidFinishLoading(self)
        }else if let error = MockURLProtocol.error{
            self.client?.urlProtocol(self, didFailWithError: error)
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {
        
    }
    
    
}
