//
//  CryptocurrencyEntity.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 27/01/24.
//

import Foundation

struct CryptocurrencyEntity {
    let id: String
    let name: String
    let symbol: String
    let price: Double
    let price24h: Double?
    let volume: Double?
    let marketCap: Double
}
