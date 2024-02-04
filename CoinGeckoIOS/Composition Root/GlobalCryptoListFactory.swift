//
//  GlobalCryptoListFactory.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 3/02/24.
//

import Foundation

class GlobalCryptoListFactory {
    static func createGlobalCryptoListView() -> GlobalCryptoListView {
        return GlobalCryptoListView(
            viewModel: createViewModel()
        )
    }
    
    private static func createViewModel() -> GlobalCryptoListViewModel {
        return GlobalCryptoListViewModel(
            getGlobalCryptoList: createUseCase()
        )
    }
    
    private static func createUseCase() -> GetGlobalCryptoListUseCaseProtocol {
        return GetGlobalCryptoListUseCase(
            repository: createRepository()
        )
    }
    
    private static func createRepository() -> GlobalCryptoListRepository {
        return GlobalCryptoListRepositoryImpl(
            apiDataSource: createDataSource(),
            errorMapper: CryptocurrencyDomainErrorMapper(),
            domainMapper: CryptocurrencyDomainMapper()
        )
    }
    
    private static func createDataSource() ->ApiDataSourceProtocol {
        return APICryptoDataSource(httpClient: createHTTPClient())
    }
    
    private static func createHTTPClient() -> HTTPClientProtocol {
        return URLSessionHTTPClient(
            requestMaker: URLSessionRequestMaker(),
            errorResolver: URLSessionErrorReslver()
        )
    }
}
