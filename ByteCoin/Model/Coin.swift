//
//  Coin.swift
//  ByteCoin
//
//  Created by Victor Marquez on 27/12/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct Coin: Codable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}

