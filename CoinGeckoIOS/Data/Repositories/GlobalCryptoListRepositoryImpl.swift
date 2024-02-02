//
//  GlobalCryptoListRepositoryImpl.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 28/01/24.
//

import Foundation

class GlobalCryptoListRepositoryImpl : GlobalCryptoListRepository {
    
    private let apiDataSource: ApiDataSourceProtocol
    private let errorMapper: CryptocurrencyDomainErrorMapper
    private let domainMapper: CryptocurrencyDomainMapper
    
    init(apiDataSource: ApiDataSourceProtocol, errorMapper: CryptocurrencyDomainErrorMapper, domainMapper: CryptocurrencyDomainMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.domainMapper = domainMapper
    }
    
    func getGlobalCryptoList() async -> Result<[CryptocurrencyEntity], CryptocurrencyDomainError> {
        
        let globalCryptoSymbolListResult = await apiDataSource.getGlobalCryptoSymbolList()
        let cryptoListResult = await apiDataSource.getCryptoList()
        
        guard case .success(let cryptoList) = cryptoListResult else {
            return .failure(errorMapper.map(error: cryptoListResult.failureValue as! HTTPClientError))
        }
        
        guard case .success(let globalCryptoSymbolList) = globalCryptoSymbolListResult else {
            return .failure(errorMapper.map(error: globalCryptoSymbolListResult.failureValue as! HTTPClientError))
        }

        // En este punto ya tenemos la lista de todas las cryptos y la lista de
        // simbolos de las cryptos globales (sacamos de la lista de todas las cryptos aquellas cuyo simbolo sea el de una crypto global)
        //cryptoList
        //globalCryptoSymbolList
        
        let globalCryptos = domainMapper.getGlobalCryptos(cryptoList: cryptoList, globalCryptoSymbolList: globalCryptoSymbolList)
        
        let globalCryptosId = domainMapper.getGlobalCryptocurrencyIds(cryptoList: cryptoList, globalCryptoSymbolList: globalCryptoSymbolList)
        
        // Aquí se optiene un diccio de [string: CryptocurrencyPriceInfoDTO]
        let priceInfoResult = await apiDataSource.getPriceInfoForCryptos(id: globalCryptosId)
        
        guard case .success(let priceInfo) = priceInfoResult else {
            return .failure(errorMapper.map(error: priceInfoResult.failureValue as! HTTPClientError))
        }

        let cryptocurrencyEntityBuilderList = domainMapper.getCryptocurrencyEntityBuilderList(globalCryptos: globalCryptos, priceInfo: priceInfo)
        
        let cryptocurrencyEntityList = domainMapper.map(cryptocurrencyEntityBuilderList: cryptocurrencyEntityBuilderList)
        
        return .success(cryptocurrencyEntityList)
    }
    
}
