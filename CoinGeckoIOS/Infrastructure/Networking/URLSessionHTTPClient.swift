//
//  URLSessionHTTPClient.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 2/02/24.
//

import Foundation

class URLSessionHTTPClient: HTTPClientProtocol {
    
    private let urlSession: URLSession
    private let requestMaker: URLSessionRequestMaker
    private let errorResolver: URLSessionErrorReslver
    
    init(urlSession: URLSession = .shared, requestMaker: URLSessionRequestMaker, errorResolver: URLSessionErrorReslver) {
        self.urlSession = urlSession
        self.requestMaker = requestMaker
        self.errorResolver = errorResolver
    }
    
    func makeRequest(urlBase: String, endpoint: Endpoint) async -> Result<Data, HTTPClientError> {
        
        guard let url = requestMaker.getUrl(urlBase: urlBase, endpoint: endpoint) else {
            return .failure(.badURL)
        }
        
        do {
            let result = try await urlSession.data(from: url)
            guard let response = result.1 as? HTTPURLResponse else {
                return .failure(.responseError)
            }
            guard response.statusCode == 200 else {
                let error = errorResolver.resolve(
                    statusCode: response.statusCode
                )
                return .failure(error)
            }
            return .success(result.0)
        } catch  {
            let error = errorResolver.resolve(error: error)
            return .failure(error)
        }
    
    }
    
}
