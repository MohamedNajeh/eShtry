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
    @IBOutlet weak var stackViewLoggingIn: UIStackView!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let addAddressVC = storyboard?.instantiateViewController(identifier: "NewAddressVC") as! NewAddressVC
        navigationController?.pushViewController(addAddressVC, animated: true)
    }
    
    
    @IBSegueAction func moreOrdersClick(_ coder: NSCoder) -> moreOrdersVC? {
        return moreOrdersVC(coder: coder, myOrders: moreOrdersArr)
    }
    
    
    @IBAction func profileClick(_ sender: Any) {
        let registerVC = storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterVC
        registerVC.checkWhichScreen="p"
        registerVC.userId = userDefaults.object(forKey: "userId") as? Int
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    @IBAction func currencyClick(_ sender: Any) {
        let currencyVC = storyboard?.instantiateViewController(identifier: "CurrencyVC") as! CurrencyVC
        navigationController?.pushViewController(currencyVC, animated: true)
    }
    
    @IBSegueAction func contactUs(_ coder: NSCoder) -> UIViewController? {
        return UIViewController(coder: coder)
    }
    
    @IBAction func termsAndConditions(_ sender: Any) {
        openURL("https://www.termsfeed.com/live/6b976f4f-9a5b-4c89-8b51-6fced7397884")
    }
    
    @IBAction func privacyPolicy(_ sender: Any) {
        openURL("https://sites.google.com/view/pola-apps/home")
    }
    
    @IBAction func dismissContactUs(segue: UIStoryboardSegue){}
    
    func openURL(_ urlString: String) {
                guard let url = URL(string:urlString) else {
                    return
                }
                UIApplication.shared.open(url, completionHandler: { success in
                    if success {
                        //print("opened")
                    } else {
                        //print("failed")
                    }
                })
            }
    
    @IBAction func logOutClick(_ sender: Any) {
        userDefaults.set(false, forKey:"login")
        meVC.showToast(controller: self, message: "Logged out", seconds: 3)
        navigateToMain()
    }
    
    override func viewWillAppear(_ animated: Bool) { ifLogin() }
    
    func ifLogin() {
        let userName = userDefaults.object(forKey: "userName") as? String ?? ""
        let isLoggedIn = userDefaults.object(forKey: "login") as? Bool ?? false

        if isLoggedIn {
            welcomeUserLabelOtlet.text = "Welcome \(userName)"
            welcomeUserViewOutlet.isHidden = false
            loginViewOutlet.isHidden = true
            myOrdersViewOutlet.isHidden = false
            myWishListViewOutlet.isHidden = false
            stackViewLoggingIn.isHidden = false
            logOutButtonOutlet.isHidden = false

        }else{
            welcomeUserViewOutlet.isHidden = true
            loginViewOutlet.isHidden = false
            myOrdersViewOutlet.isHidden = true
            myWishListViewOutlet.isHidden = true
            stackViewLoggingIn.isHidden = true
            logOutButtonOutlet.isHidden = true
        }
        
    }
    
    func navigateToMain() {
        let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first
        let tabBarController = keyWindow?.rootViewController as! UITabBarController
        tabBarController.selectedIndex = 0
        self.dismiss(animated: true, completion: {
            self.navigationController?.popToRootViewController(animated: false)
        })
    }
}
