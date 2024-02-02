//
//  HTTPClientProtocol.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 1/02/24.
//

import Foundation

protocol HTTPClientProtocol {
    func makeRequest(urlBase: String, endpoint: Endpoint) async -> Result<Data, HTTPClientError>
}
