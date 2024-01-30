//
//  CryptocurrencyBasicDTO.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 29/01/24.
//

import Foundation

struct CryptocurrencyBasicDTO: Codable {
    let id: String
    let symbol: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
    }
}
