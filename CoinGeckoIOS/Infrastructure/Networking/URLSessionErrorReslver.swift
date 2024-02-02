//
//  URLSessionErrorReslver.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 2/02/24.
//

import Foundation

class URLSessionErrorReslver {
    func resolve(statusCode: Int) -> HTTPClientError {
        guard statusCode != 429 else {
            return .tooManyRequests
        }
        guard statusCode < 500 else {
            return .clientError
        }
        return .serverError
    }
    
    func resolve(error: Error) -> HTTPClientError {
        return .generic
    }
}
