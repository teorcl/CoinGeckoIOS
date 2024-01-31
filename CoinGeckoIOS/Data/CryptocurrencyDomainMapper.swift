//
//  CryptocurrencyDomainMapper.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 30/01/24.
//

import Foundation

class CryptocurrencyDomainMapper {
    
    func getGlobalCryptocurrencyIds(cryptoList:[CryptocurrencyBasicDTO], globalCryptoSymbolList: [String]) -> [String]{
        
        let globalCryptos = getGlobalCryptos(cryptoList: cryptoList, globalCryptoSymbolList: globalCryptoSymbolList)
        
        let globalCryptosId = globalCryptos.map { globalCrypto in
            return globalCrypto.id
        }
        
        return globalCryptosId
    }
    
    func getGlobalCryptos(cryptoList:[CryptocurrencyBasicDTO], globalCryptoSymbolList: [String]) -> [CryptocurrencyBasicDTO] {
        
        let globalCryptos = cryptoList.filter { crypto in
            return globalCryptoSymbolList.contains(crypto.symbol)
        }
        
        return globalCryptos
    }
    
    func map(cryptocurrencyEntityBuilderList:[CryptocurrencyEntityBuilder]) -> [CryptocurrencyEntity] {
        let cryptocurrencyEntityList = cryptocurrencyEntityBuilderList.compactMap { cryptocurrencyEntityBuilder in
            return cryptocurrencyEntityBuilder.build()
        }
        return cryptocurrencyEntityList
    }
    
    func getCryptocurrencyEntityBuilderList(globalCryptos:[CryptocurrencyBasicDTO], priceInfo: [String:CryptocurrencyPriceInfoDTO]) ->[CryptocurrencyEntityBuilder]{
        let cryptocurrencyEntityBuilderList = globalCryptos.map { globalCrypto in
            return CryptocurrencyEntityBuilder(
                id: globalCrypto.id,
                name: globalCrypto.name,
                symbol: globalCrypto.symbol
            )
        }
        
        cryptocurrencyEntityBuilderList.forEach { cryptocurrencyEntityBuilder in
            if let priceInfo = priceInfo[cryptocurrencyEntityBuilder.id] {
                cryptocurrencyEntityBuilder.price = priceInfo.price
                cryptocurrencyEntityBuilder.price24h = priceInfo.price24h
                cryptocurrencyEntityBuilder.volume24h = priceInfo.volume24h
                cryptocurrencyEntityBuilder.marketCap = priceInfo.marketCap
            }
        }
        
        return cryptocurrencyEntityBuilderList
    }
}
