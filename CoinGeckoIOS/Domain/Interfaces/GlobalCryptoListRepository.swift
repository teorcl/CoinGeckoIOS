//
//  GlobalCryptoListRepository.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 27/01/24.
//

import Foundation

protocol GlobalCryptoListRepository {
    func getGlobalCryptoList() async -> Result<[CryptocurrencyEntity],CryptocurrencyDomainError>
}
