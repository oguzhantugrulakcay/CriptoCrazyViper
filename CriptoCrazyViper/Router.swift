//
//  Router.swift
//  CriptoCrazyViper
//
//  Created by Oğuzhantuğrul Akçay on 13.06.2024.
//

import Foundation
import UIKit

//class protochol
//EntryPoint


typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry : EntryPoint? {get}
    static func startExecution()->AnyRouter
}

class CryptoRouter : AnyRouter {
    var entry: EntryPoint?
    static func startExecution() -> any AnyRouter {
        let router=CryptoRouter()
        var view : AnyView=CryptoViewController()
        var presenter :AnyPresenter=CryptoPresenter()
        var interactor :AnyInteractor=CryptoInteractor()
        
        view.presenter=presenter
        
        presenter.interactor=interactor
        presenter.router=router
        presenter.view=view
        
        interactor.presenter=presenter
        router.entry = view as? EntryPoint
        return router
    }
    
    
}
