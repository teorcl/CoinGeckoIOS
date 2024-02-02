//
//  CryptocurrencyGlobalInfoDTO.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 31/01/24.
//

import Foundation


struct CryptocurrencyGlobalInfoDTO: Codable {
    let data: CryptocurrencyGlobalData
    
    struct CryptocurrencyGlobalData: Codable {
        let totalMarketCap: [String: Double]
        
        enum CodingKeys: String, CodingKey {
            case totalMarketCap = "total_market_cap"
        }
    }
}

