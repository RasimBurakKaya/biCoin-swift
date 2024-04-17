//
//  CoinData.swift
//  BiCoin
//
//  Created by Rasim Burak Kaya on 17.04.2024.
//

import Foundation

struct CoinData: Codable{
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
    
    var rateString: String{
        let string = String(format: "%.1f", rate)
        return string
    }
}
