//
//  CryptoListItemView.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 4/02/24.
//

import SwiftUI

struct CryptoListItemView: View {
    let cryptoItem: CryptoListPresentableItem
    var body: some View {
        VStack {
            HStack {
                VStack( alignment: .leading ) {
                    Text(cryptoItem.name)
                        .font(.title3).bold()
                    .lineLimit(1)
                    Text(item.symbol)
                        .font(.headline)
                }
                
                Spacer()
                
                VStack( alignment: .trailing ) {
                    Text(cryptoItem.price)
                        .font(.headline)
                    .lineLimit(1)
                    Text(
                        (cryptoItem.isPriceChangePostive ? "+" : "") + cryptoItem.price24h
                    ).font(.headline)
                        .foregroundStyle(
                            cryptoItem.isPriceChangePostive ? .green : .red
                        )
                        
                }
            }
            HStack{
                VStack( alignment: .leading ) {
                    Text("Market cap:")
                        .font(.system(size: 10))
                    Text("24 h: ")
                        .font(.system(size: 10))
                }
                
                Spacer()
                
                VStack( alignment: .trailing ) {
                    Text(item.marketCap)
                        .font(.system(size: 10))
                    Text(item.volume24h)
                        .font(.system(size: 10))
                }
            }
        }
    }
}

let domainModel = CryptocurrencyEntity(
    id: "btc",
    name: "Bitcoin",
    symbol: "btc",
    price: 24000.43,
    price24h: 1.23,
    volume24h: 340000000,
    marketCap: 1340000000
)
let item = CryptoListPresentableItem(domainModel: domainModel)

#Preview {
    CryptoListItemView(cryptoItem: item)
}
