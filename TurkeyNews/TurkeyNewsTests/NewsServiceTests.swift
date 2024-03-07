//
//  NewsServiceTests.swift
//  TurkeyNewsTests
//
//  Created by Hakkı Can Şengönül on 7.03.2024.
//

import XCTest
@testable import TurkeyNews
final class NewsServiceTests: XCTestCase {
    
    var model: Data?
    var weatherData: Data?
    var mockError: NSError?
    var urlSessionConfiguration: URLSessionConfiguration?
    var session: URLSession?
    var urlSessionProvider: URLSessionProvider?
    var apiClient: APIClient?
    var endPoint: Endpoint?
    
    override func setUpWithError() throws {
        model  = """
{
  "success": true,
  "result": [
    {
      "key": "0",
      "url": "https://www.sabah.com.tr/gundem/2018/09/05/tskdan-flas-aciklama-hepsi-imha-edildi",
      "description": "TSK: \\\"Irak kuzeyi Sinath-Haftanin, Zap, Hakurk ve Kandil bölgeleri ile Hakkâri/Yüksekova kırsalına 04 Eylül 2018 tarihinde düzenlenen hava harekâtı neticesinde, bölücü terör örgütü tarafından sığınak/barınak,...Devamı için tıklayınız",
      "image": "https://iasbh.tmgrup.com.tr/dff773/320/320/0/0/345/345?u=https://isbh.tmgrup.com.tr/sbh/2018/09/05/tskdan-flas-aciklama-hepsi-imha-edildi-1536125229353.jpg",
      "name": "TSK'dan flaş açıklama: Hepsi imha edildi",
      "source": "Sabah"
    }
]
}
""".data(using: .utf8)
        mockError = NSError(domain: "Error", code: 404, userInfo: nil)
        urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration?.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: urlSessionConfiguration!)
        urlSessionProvider = URLSessionProvider(session: session!)
        apiClient = APIClient(urlSessionProvider: urlSessionProvider!)
        endPoint = Endpoint.fetchGetNewsData(queryItems: [.init(name: "country", value: "tr"), .init(name: "tag", value: "general")])
    }
    
    override func tearDownWithError() throws {
        model  = nil
        mockError = nil
        urlSessionConfiguration = nil
        session = nil
        urlSessionProvider = nil
        apiClient = nil
        endPoint = nil
    }
    
    func testNewsService_shouldSuccess_returnTrue() throws{
        
        //arrange
        MockURLProtocol.data = model
        let expectation = expectation(description: "NewsServiceTests")
        //act
        NewsService(apiClient: apiClient!).fetchNewsData(endPoint: endPoint!) { result in
            switch result{
            case .success(let model):
                print(model)
                //asssert
                XCTAssertNotNil(model)
                expectation.fulfill()
                return
            case .failure(let error):
                print(error)
                //asssert
                XCTAssertNil(error)
                expectation.fulfill()
                return
            }
        }
        self.wait(for: [expectation], timeout: 5)
        
    }
    func testNewsService_shouldFailed_returnFalse() throws{
        
        //arrange
        MockURLProtocol.error = mockError
        let expectation = expectation(description: "NewsServiceTests")
        //act
        NewsService(apiClient: apiClient!).fetchNewsData(endPoint: endPoint!) { result in
            switch result{
            case .success(let model):
                print(model)
                //asssert
                XCTAssertNil(model)
                expectation.fulfill()
                return
            case .failure(let error):
                print(error)
                //asssert
                XCTAssertNotNil(error)
                expectation.fulfill()
                return
            }
        }
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    
}
