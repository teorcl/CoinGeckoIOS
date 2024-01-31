//
//  Foundation+Extensions.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 31/01/24.
//

import Foundation

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
