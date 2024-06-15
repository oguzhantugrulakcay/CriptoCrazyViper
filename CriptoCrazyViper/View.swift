//
//  View.swift
//  CriptoCrazyViper
//
//  Created by Oğuzhantuğrul Akçay on 13.06.2024.
//

import Foundation
import UIKit
// talls to->presenter
// Class,protocol
//viewController

protocol AnyView{
    var presenter : AnyPresenter? {get set}
    
    func update(with crtptos:[Crypto])
    func update(with error:String)
}

class DetailViewController : UIViewController {
    var presenter: AnyPresenter?
        
        var currency : String = ""
        var price : String = ""
        
        private let currencyLabel : UILabel = {
           let label = UILabel()
            label.isHidden = true
            label.text = "Currency Label"
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()
        
        private let priceLabel : UILabel = {
           let label = UILabel()
            label.isHidden = true
            label.text = "Price Label"
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .yellow
            view.addSubview(currencyLabel)
            view.addSubview(priceLabel)
           
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            currencyLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)
            priceLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 + 50, width: 200, height: 50)
            currencyLabel.text = currency
            priceLabel.text = price
            currencyLabel.isHidden = false
            priceLabel.isHidden = false
        }
}

class CryptoViewController : UIViewController,AnyView,UITableViewDelegate,UITableViewDataSource{
    var presenter: AnyPresenter?
    var cryptos : [Crypto] = []
    
    private let tableView:UITableView = {
       let table=UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden=true
        return table
    }()
    
    private let messageLabel : UILabel = {
    let label=UILabel()
        label.isHidden=false
        label.text="Downloading..."
        label.font=UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.backgroundColor = .darkGray
        view.backgroundColor = .darkGray
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame=view.bounds
        messageLabel.frame=CGRect(x: view.frame.width/2-100, y: view.frame.height/2-25, width: 200, height: 50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.textProperties.color = .white
        content.secondaryText=cryptos[indexPath.row].price
        content.secondaryTextProperties.color = .white
        cell.contentConfiguration=content
        cell.backgroundColor = .darkGray
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print(cryptos[indexPath.row].currency)
            let nextViewController = DetailViewController()
            nextViewController.price = cryptos[indexPath.row].price
            nextViewController.currency = cryptos[indexPath.row].currency
            self.present(nextViewController, animated: true, completion: nil)
        }
    
    func update(with crtptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos=crtptos
            self.messageLabel.isHidden=true
            self.tableView.reloadData()
            self.tableView.isHidden=false
        }
    }
    
    func update(with error: String) {
        self.cryptos=[]
        self.tableView.isHidden=true
        self.messageLabel.text=error
        self.messageLabel.isHidden=false
    }
    
    
    
}
