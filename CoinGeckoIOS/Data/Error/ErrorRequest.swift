//
//  ErrorRequest.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 28/01/24.
//

import Foundation

enum HTTPClientError: Error {
    case clientError
    case serverError
    case generic
    case parsingError
    case badURL
    case responseError
    case tooManyRequests
}
