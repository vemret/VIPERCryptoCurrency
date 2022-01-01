//
//  Interactor.swift
//  CryptocurrencyVIPER
//
//  Created by Vahit Emre TELLİER on 27.12.2021.
//

import Foundation

// Class, protocol
// talks to => Presenter

// mostly responsible for API calls.
// Operations in this layer occur independently of the UI.

protocol AnyInteractor {
    
    var presenter : AnyPresenter? { get set }
    
    func downloadCryptos()
}

class CryptoInteractor : AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
//        http://data.fixer.io/api/latest?access_key=0f973842c640ca875d65d5688234e24d
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/IA32-CryptoComposeData/main/cryptolist.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            
//            NetworkError comes from enum in presenter
            guard let data = data, error == nil else {
                
                self?.presenter?.cryptoDownload(result: .failure(NetworkError.NetworkFail))
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([CryptoModel].self, from: data)
                self?.presenter?.cryptoDownload(result: .success(coins))
            } catch {
                self?.presenter?.cryptoDownload(result: .failure(NetworkError.ParsingFail))
            }
            
        }
        task.resume()
        
    }
    
    
}
