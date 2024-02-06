//
//  GlobalCryptoListViewModel.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 2/02/24.
//

import Foundation


class GlobalCryptoListViewModel: ObservableObject {
    
    private let getGlobalCryptoList: GetGlobalCryptoListUseCaseProtocol
    private let errorMapper: CryptocurrencyPresentableErrorMapper
    @Published var cryptos: [CryptoListPresentableItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(getGlobalCryptoList: GetGlobalCryptoListUseCaseProtocol, errorMapper: CryptocurrencyPresentableErrorMapper) {
        self.getGlobalCryptoList = getGlobalCryptoList
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        isLoading = true
        Task {
            let result = await getGlobalCryptoList.execute()
            
            
            guard case .success(let cryptosObtained) = result else {
                handleError(error: result.failureValue as? CryptocurrencyDomainError)
                return
            }

           
            let cryptocurrenciesPresentable = cryptosObtained.map { cryptocurrency in
                return CryptoListPresentableItem(domainModel: cryptocurrency)
            }
            
            Task { @MainActor in
                isLoading = false
                self.cryptos = cryptocurrenciesPresentable
            }
        }
    }
    
    private func handleError(error: CryptocurrencyDomainError?) {
        let errorMessage = errorMapper.map(error: error)
        Task { @MainActor in
            isLoading = false
            self.errorMessage = errorMessage
        }
        
    }
}
