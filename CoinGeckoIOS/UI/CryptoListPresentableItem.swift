//
//  CryptoListPresentableItem.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 5/02/24.
//

import Foundation

// MARK: - Formateo de los datos para que sean presentables en la vista
struct CryptoListPresentableItem {
    let id: String
    let name: String
    let symbol: String
    let price: String
    let price24h: String
    let volume24h: String
    let marketCap: String
    let isPriceChangePostive: Bool
    
    init(domainModel: CryptocurrencyEntity){
        self.id = domainModel.id
        self.name = domainModel.name
        self.symbol = domainModel.symbol
        self.price = "\(domainModel.price) $"
        self.price24h = domainModel.price24h != nil ? "\(domainModel.price24h!) %" : "-"
        self.volume24h = domainModel.volume24h != nil ? "\(domainModel.volume24h!) $" : "-"
        self.marketCap = "\(domainModel.marketCap) $"
        self.isPriceChangePostive = (domainModel.price24h ?? 0) >= 0
    }
}
