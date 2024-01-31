//
//  CryptocurrencyDomainErrorMapper.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 31/01/24.
//

import Foundation

class CryptocurrencyDomainErrorMapper {
    func map(error: HTTPClientError) -> CryptocurrencyDomainError {
        .generic
    }
}
