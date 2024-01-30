//
//  ApiDataSource.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 28/01/24.
//

import Foundation

protocol ApiDataSource {
    func getGlobalCryptoSymbolList() async -> Result<[String], HTTPClientError>
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError>
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String:CryptocurrencyPriceInfoDTO], HTTPClientError>
}
