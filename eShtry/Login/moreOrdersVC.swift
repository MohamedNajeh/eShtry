//
//  moreOrdersVC.swift
//  FinalDemo
//
//  Created by Pola on 3/12/22.
//  Copyright © 2022 Pola. All rights reserved.
//

import UIKit

class moreOrdersVC: UITableViewController {
    
    var myOrders : [Orders] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init?(coder: NSCoder, myOrders : [Orders]) {
        self.myOrders = myOrders
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        print(coder.error?.localizedDescription ?? "")
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return myOrders.count}
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ordersCell", for: indexPath)
        cell.textLabel?.text = myOrders[indexPath.row].orderName
        cell.detailTextLabel?.text = myOrders[indexPath.row].Price

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {return 65}
    
}
