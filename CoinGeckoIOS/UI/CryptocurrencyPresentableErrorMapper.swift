//
//  CryptocurrencyPresentableErrorMapper.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 5/02/24.
//

import Foundation

class CryptocurrencyPresentableErrorMapper {
    func map(error: CryptocurrencyDomainError?) -> String {
        guard error == .tooManyRequests else {
            return "Something went wrong"
        }
        
        return "You have exceeded the limit of requests. Try again later"
        
    }
}
