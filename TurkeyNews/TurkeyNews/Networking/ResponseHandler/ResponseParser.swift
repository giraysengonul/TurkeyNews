//
//  ResponseParser.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import Foundation
/// ResponseParser
final class ResponseParser{
    
    //Elements
    private let decoder: JSONDecoder
    
    /// Init
    /// - Parameter decoder: JsonDecoder
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    /// Data Parser Process
    /// - Parameters:
    ///   - data: data
    ///   - parsingModel: Model
    ///   - completion: Data or Error
    public func dataParser<T: Codable>(with data: Data, parsingModel: T.Type, completion: @escaping(Result<T,Error>) -> Void){
        
        do{
            let parsingData = try decoder.decode(T.self, from: data)
            completion(.success(parsingData))
            return
        }catch{
            completion(.failure(NetworkError.decodeError))
            return
        }
        
    }
    
}
