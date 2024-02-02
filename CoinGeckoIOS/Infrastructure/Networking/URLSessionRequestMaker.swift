//
//  URLSessionRequestMaker.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 2/02/24.
//

import Foundation

class URLSessionRequestMaker {
    func getUrl(urlBase: String, endpoint: Endpoint) -> URL? {
        var urlComponents = URLComponents(string: urlBase + endpoint.path)
        let urlQueryParameters = endpoint.queryParamters.map { queryParameter in
            return URLQueryItem(
                name: queryParameter.key,
                value: "\(queryParameter.value)"
            )
        }
        
        urlComponents?.queryItems = urlQueryParameters
        let url = urlComponents?.url
        return url
    }
}
