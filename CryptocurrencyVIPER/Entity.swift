//
//  Entity.swift
//  CryptocurrencyVIPER
//
//  Created by Vahit Emre TELLİER on 27.12.2021.
//

import Foundation

// Struct

// Contains basic model objects used by the Interactor

struct CryptoModel : Decodable {
    let currency : String
    let price : String
}
