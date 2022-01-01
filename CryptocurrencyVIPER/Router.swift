//
//  Router.swift
//  CryptocurrencyVIPER
//
//  Created by Vahit Emre TELLİER on 27.12.2021.
//

import Foundation
import UIKit

//Class, protocol
// EntryPoint

//Download Data


//contains navigation logic for describing which screens are shown in which order.

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    
    var entry : EntryPoint? {get}
    
    static func startExecution() -> AnyRouter
        
}

class CryptoRouter : AnyRouter {
    
    var entry: EntryPoint?
    
//    layers connected
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
}
