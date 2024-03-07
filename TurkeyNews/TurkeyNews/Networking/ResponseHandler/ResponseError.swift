//
//  ResponseError.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import Foundation
final class ResponseError{
    
    /// Parsing Error
    /// - Parameter statusCode: HTTPURLResponse
    /// - Returns: NetworkError
    public func parseError
    (
        statusCode: Int
    )
    -> NetworkError
    {
        switch statusCode {
        case 400...499:
            return .clientError(statusCode)
        case 500...599:
            return .serverError(statusCode)
        default:
            return .unknownError
        }
    }
}
