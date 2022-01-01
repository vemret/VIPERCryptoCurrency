//
//  View.swift
//  CryptocurrencyVIPER
//
//  Created by Vahit Emre TELLİER on 27.12.2021.
//

import Foundation
import UIKit

// Talks to _> Presenter
// Class, protocol
// ViewController

//displays what it is told to by the Presenter and relays user input back to the Presenter.

protocol AnyView {
    
    var presenter : AnyPresenter? {get set}
    
    func update(with coin : [CryptoModel])
    func update(with error : String)
    
    
}

class CryptoViewController : UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    
    var presenter : AnyPresenter?
    
    var coins : [CryptoModel] = []
    
//  createed table View
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
//    messsage Label features
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Loading.."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightText
        
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        size
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = coins[indexPath.row].currency
        content.secondaryText = coins[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .clear
        return cell
    }
    
    
    func update(with coin : [CryptoModel]) {
        DispatchQueue.main.async {
            self.coins = coin
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    func update(with error: String) {
        DispatchQueue.main.async {
            self.coins = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
    }
}
