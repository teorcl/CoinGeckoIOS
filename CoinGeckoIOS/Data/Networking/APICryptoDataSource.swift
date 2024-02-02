//
//  APICryptoDataSource.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 31/01/24.
//

import Foundation

class APICryptoDataSource: ApiDataSourceProtocol {
    
    private let httpClient: HTTPClientProtocol
    private let urlbase = "https://api.coingecko.com/api/v3/"
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getGlobalCryptoSymbolList() async -> Result<[String], HTTPClientError> {
        let endpoint = Endpoint(path: "global", queryParamters: [:], method: .get)
        let result = httpClient.makeRequest(urlBase: urlbase, endpoint: endpoint)
        
        guard case .success(let data) = result else {
            let error = result.failureValue as? HTTPClientError
            return .failure(handleError(error: error))
        }
        
        guard let symbolList = try? JSONDecoder().decode(CryptocurrencyGlobalInfoDTO.self, from: data) else {
            return .failure(.parsingError)
        }

        let globalCryptoSymbolList = symbolList.data.totalMarketCap.map { totalMarketCap in
            return totalMarketCap.key
        }
        
        return .success(globalCryptoSymbolList)
    }
    
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError> {
        
        let endpoint = Endpoint(
            path: "coins/list",
            queryParamters: [:],
            method: .get
        )
        let result = httpClient.makeRequest(urlBase: urlbase, endpoint: endpoint)
        
        guard case .success(let data) = result else {
            let error = result.failureValue as? HTTPClientError
            return .failure(handleError(error: error))
        }
        
        guard let cryptoList = try? JSONDecoder().decode([CryptocurrencyBasicDTO].self, from: data) else {
            return .failure(.parsingError)
        }

        return .success(cryptoList)
    }
    
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String : CryptocurrencyPriceInfoDTO], HTTPClientError> {
        
        let queryParameters :[String : Any] = [
            "ids" : id,
            "vs_currencies" : "usd",
            "include_market_cap" : true,
            "include_24hr_vol" : true,
            "include_24hr_change" : true
        ]
        
        let endpoint = Endpoint(
            path: "simple/price",
            queryParamters: queryParameters,
            method: .get
        )
        
        let result = httpClient.makeRequest(urlBase: urlbase, endpoint: endpoint)
       
        guard case .success(let data) = result else {
            let error = result.failureValue as? HTTPClientError
            return .failure(handleError(error: error))
        }
        
        guard let priceInfoCryptos = try? JSONDecoder().decode([String : CryptocurrencyPriceInfoDTO].self, from: data) else {
            return .failure(.parsingError)
        }
        
        return .success(priceInfoCryptos)
    }
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else { return .generic }
        return error
    }
    
}
