//
//  GlobalCryptoListRepositoryImpl.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 28/01/24.
//

import Foundation

class CryptocurrencyDomainErrorMapper {
    func map(error: HTTPClientError) -> CryptocurrencyDomainError {
        .generic
    }
}

class GlobalCryptoListRepositoryImpl : GlobalCryptoListRepository {
    
    private let apiDataSource: ApiDataSource
    private let errorMapper: CryptocurrencyDomainErrorMapper
    
    init(apiDataSource: ApiDataSource, errorMapper: CryptocurrencyDomainErrorMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
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
        
        let globalCryptos = cryptoList.filter { crypto in
            return globalCryptoSymbolList.contains(crypto.symbol)
        }
        
        let globalCryptosId = globalCryptos.map { globalCrypto in
            return globalCrypto.id
        }
        
        // Aquí se optiene un diccio de [string: CryptocurrencyPriceInfoDTO]
        let priceInfoResult = await apiDataSource.getPriceInfoForCryptos(id: globalCryptosId)
        
        guard case .success(let priceInfo) = priceInfoResult else {
            return .failure(errorMapper.map(error: priceInfoResult.failureValue as! HTTPClientError))
        }

        
        <#code#>
    }
    
}

extension Result {
    var failureValue: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
