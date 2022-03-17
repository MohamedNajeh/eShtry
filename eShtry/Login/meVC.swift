//
//  meVC.swift
//  FinalDemo
//
//  Created by Pola on 3/10/22.
//  Copyright © 2022 Pola. All rights reserved.
//

import UIKit

class meVC: UIViewController {
    
    var moreOrdersArr : [OrdersTemp] = []
    var myOrder1 : OrdersTemp = OrdersTemp()
    var myOrder2 : OrdersTemp = OrdersTemp()
    
    @IBOutlet weak var order1OutletLabel: UILabel!
    @IBOutlet weak var order2OutletLabel: UILabel!
    @IBOutlet weak var price1OutletLabel: UILabel!
    @IBOutlet weak var prive2OutletLabel: UILabel!
    

    @IBOutlet weak var welcomeUserLabelOtlet: UILabel!
    @IBOutlet weak var welcomeUserViewOutlet: UIView!
    @IBOutlet weak var loginViewOutlet: UIView!
    @IBOutlet weak var myOrdersViewOutlet: UIView!
    @IBOutlet weak var myWishListViewOutlet: UIView!
    @IBOutlet weak var logOutButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myOrdersViewOutlet.isHidden = true
        myWishListViewOutlet.isHidden = true
        logOutButtonOutlet.isHidden = true
        welcomeUserViewOutlet.isHidden = true
        
        myOrder1.orderName = order1OutletLabel.text
        myOrder1.Price = price1OutletLabel.text
        myOrder2.orderName = order2OutletLabel.text
        myOrder2.Price = prive2OutletLabel.text
        
        moreOrdersArr.append(myOrder1)
        moreOrdersArr.append(myOrder2)
        
    }
    

    
    @IBAction func loginRegister(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    

    @IBAction func myAddressClick(_ sender: Any) {
        let addressVC = storyboard?.instantiateViewController(identifier: "AddressVC") as! AddressVC
        navigationController?.pushViewController(addressVC, animated: true)
    }
    
    
    @IBSegueAction func moreOrdersClick(_ coder: NSCoder) -> moreOrdersVC? {
        return moreOrdersVC(coder: coder, myOrders: moreOrdersArr)
    }
    
    
    @IBAction func profileClick(_ sender: Any) {
        let registerVC = storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterVC
        registerVC.checkWhichScreen="p"
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    @IBAction func currencyClick(_ sender: Any) {
        let currencyVC = storyboard?.instantiateViewController(identifier: "CurrencyVC") as! CurrencyVC
        navigationController?.pushViewController(currencyVC, animated: true)
    }
    
    @IBSegueAction func contactUs(_ coder: NSCoder) -> UIViewController? {
        return UIViewController(coder: coder)
    }
    
    @IBAction func dismissContactUs(segue: UIStoryboardSegue){}
    
}
