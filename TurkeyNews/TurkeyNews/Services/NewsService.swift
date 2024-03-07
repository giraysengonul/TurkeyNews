//
//  NewsService.swift
//  TurkeyNews
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import Foundation
/// NewsService
final class NewsService{
    
    /// Elements
    private let apiClient: APIClient
    
    /// Init
    /// - Parameter apiClient: APIClient
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        
    }
    
    /// FetchNewsData
    /// - Parameters:
    ///   - endPoint: Endpoint
    ///   - completion: News or Error
    public func fetchNewsData(endPoint: Endpoint, completion: @escaping(Result<News,Error>) -> Void){
        apiClient.execute(endPoint: endPoint, parsingModel: News.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
                return
            case .failure(let failure):
                completion(.failure(failure))
                return
            }
        }
    }
    
}
