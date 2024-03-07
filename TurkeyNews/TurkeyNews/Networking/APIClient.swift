//
//  APIClient.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import Foundation
/// APIClient
final class APIClient{
    /// Singleton
    static let shared = APIClient()
    
    ///Elements
    private let urlSessionProvider: URLSessionProvider
    private let responseError: ResponseError
    private let responseParser: ResponseParser
    private let networkLogger: NetworkLogger
    
    /// Init
    /// - Parameters:
    ///   - urlSessionProvider: URLSessionProvider
    ///   - responseError: Response Error
    ///   - responseParser: Response Parser
    ///   - networkLogger: Network Logger
    init
    (
        urlSessionProvider: URLSessionProvider = URLSessionProvider(session: .shared),
        responseError: ResponseError = ResponseError(),
        responseParser: ResponseParser = ResponseParser(),
        networkLogger: NetworkLogger = NetworkLogger.shared
    )
    {
        self.urlSessionProvider = urlSessionProvider
        self.responseError = responseError
        self.responseParser = responseParser
        self.networkLogger = networkLogger
    }
    
    /// Execute Process
    /// - Parameters:
    ///   - endPoint: Endpoint(URLRequest)
    ///   - parsingModel: Parsing Model
    ///   - completion: Model or Error
    public func execute<T: Codable>(endPoint: Endpoint, parsingModel: T.Type, completion: @escaping(Result<T,Error>) -> Void){
        
        //Ethernet Controll
        guard ReachabilityHelper.isConnectedToNetwork() else{
            print("Not connected to the internet")
            completion(.failure(NetworkError.ethernetError))
            return
        }
        //URLRequest Controll
        guard let urlRequest = endPoint.requestBuilder() else{
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        //Data Task Process
        urlSessionProvider.sessionDataTask(with: urlRequest) {[weak self] data, response, error in
           
            self?.networkLogger.log(request: urlRequest)
            guard error == nil else{
                completion(.failure(NetworkError.invalidRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse else{
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            guard (200...300).contains(response.statusCode) else{
                let error = self?.responseError.parseError(statusCode: response.statusCode)
                completion(.failure(error ?? .unknownError))
                return
            }
            guard let data = data else{
                completion(.failure(NetworkError.noData))
                return
            }
            self?.networkLogger.log(httpResponse: response, data: data)
            
            //Parser Process
            self?.responseParser.dataParser(with: data, parsingModel: parsingModel) { result in
                switch result {
                case .success(let model):
                    completion(.success(model))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }
        }.resume()
    }
    
}
