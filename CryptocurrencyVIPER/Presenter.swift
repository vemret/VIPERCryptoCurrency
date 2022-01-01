//
//  Presenter.swift
//  CryptocurrencyVIPER
//
//  Created by Vahit Emre TELLİER on 27.12.2021.
//

import Foundation
import UIKit

//Class, protocol
// talks to -> interactor, router, view

// Presenter is the layer at the center of this architecture.
// It provides communication with other layers.


// formed switch-case for error message
enum NetworkError : Error {
    case NetworkFail
    case ParsingFail
}

protocol AnyPresenter {
    
    var router : AnyRouter? { get set }
    var interactor : AnyInteractor? { get set }
    var view : AnyView? { get set }
    
    func cryptoDownload (result: Result<[CryptoModel],Error>)
}

class CryptoPresenter : AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func cryptoDownload(result: Result<[CryptoModel], Error>) {
        switch result {
        case .success(let coins):
            view?.update(with: coins)
        case .failure(_):
            view?.update(with: "an error has occurred.")
            
        }
        
    }
    
    
}
