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
            List (viewModel.cryptos, id: \.id){ crypto in
                Text(crypto.name)
            }
        }.onAppear {
            viewModel.onAppear()
        }
    }
}

