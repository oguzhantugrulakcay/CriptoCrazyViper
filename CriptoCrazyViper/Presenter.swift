//
//  Presenter.swift
//  CriptoCrazyViper
//
//  Created by Oğuzhantuğrul Akçay on 13.06.2024.
//

import Foundation

//class,protocol
//talsk to->interactor,router,view


protocol AnyPresenter{
    var router:AnyRouter?{get set}
    var interactor : AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[Crypto],Error>)
}

class CryptoPresenter : AnyPresenter{
    var router:  AnyRouter?
    
    var interactor: AnyInteractor?{
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], any Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(let error):
            view?.update(with: "Try again later...")
        }
    }
    
    
}
