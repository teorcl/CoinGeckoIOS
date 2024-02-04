//
//  GetGlobalCryptoListUseCase.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 27/01/24.
//

import Foundation

protocol GetGlobalCryptoListUseCaseProtocol {
    func execute() async -> Result<[CryptocurrencyEntity], CryptocurrencyDomainError>
}


class GetGlobalCryptoListUseCase: GetGlobalCryptoListUseCaseProtocol {
    
    private let repository: GlobalCryptoListRepository
    
    init(repository: GlobalCryptoListRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<[CryptocurrencyEntity], CryptocurrencyDomainError> {
        
        let result = await repository.getGlobalCryptoList()
        
        guard let cryptoCurrencyList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        return .success(cryptoCurrencyList.sorted {$0.marketCap > $1.marketCap})
    }
}
