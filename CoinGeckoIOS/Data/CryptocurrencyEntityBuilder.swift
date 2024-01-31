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
        guard let price = price,
              let marketCap = marketCap else {
            return nil
        }
         return CryptocurrencyEntity(
            id: id,
            name: name,
            symbol: symbol,
            price: price,
            price24h: price24h,
            volume24h: volume24h,
            marketCap: marketCap
        )
        
    }
}
