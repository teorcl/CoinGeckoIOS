//
//  Endpoint.swift
//  CoinGeckoIOS
//
//  Created by Teodoro Calle Lara on 1/02/24.
//

import Foundation

struct Endpoint {
    let path: String
    let queryParamters: [String:Any]
    let method: HTTPMethod
}
