//
//  Interrector.swift
//  CriptoCrazyViper
//
//  Created by Oğuzhantuğrul Akçay on 13.06.2024.
//

import Foundation

//Class,protocol
//talks to -> presenter

enum NetworkError:Error{
    case NetworkFailed
    case ParsingFailed
}

protocol AnyInteractor{
    var presenter:AnyPresenter?{get set}
    
    func downloadCryptos()
}

class CryptoInteractor : AnyInteractor{
    var presenter: (any AnyPresenter)?
    
    func downloadCryptos() {
        
        guard let url=URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDATASET/master/crypto.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data=data,error==nil else{
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            
            do{
                let crypros=try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadCrypto(result: .success(crypros))
            }catch{
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
        }
        
        task.resume()
    }
    
    
}
