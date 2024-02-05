//
//  CryptocurrencyEntityBuilder.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 30/01/24.
//

import Foundation

class CryptocurrencyEntityBuilder {
    let id: String
    let name: String
    let symbol: String
    var price: Double?
    var price24h: Double?
    var volume24h: Double?
    var marketCap: Double?
    
    init(id: String, name: String, symbol: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
    }
    
    func build() -> CryptocurrencyEntity? {
        guard let price = price?.truncate(toDecimalPlaces: 2),
              let marketCap = marketCap?.truncate(toDecimalPlaces: 2) else {
            return nil
        }
         return CryptocurrencyEntity(
            id: id,
            name: name,
            symbol: symbol,
            price: price,
            price24h: price24h?.truncate(toDecimalPlaces: 2),
            volume24h: volume24h?.truncate(toDecimalPlaces: 2),
            marketCap: marketCap
        )
        
    }
}
