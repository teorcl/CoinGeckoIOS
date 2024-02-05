//
//  GlobalCryptoListView.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 3/02/24.
//

import SwiftUI

struct GlobalCryptoListView: View {
    
    @ObservedObject private var viewModel: GlobalCryptoListViewModel 
    
    init(viewModel: GlobalCryptoListViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView().progressViewStyle(.circular)
            } else {
                List (viewModel.cryptos, id: \.id){ crypto in
                    CryptoListItemView(cryptoItem: crypto)
                }
            }
        }
        .ignoresSafeArea(.all)
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    GlobalCryptoListFactory.createGlobalCryptoListView()
}
