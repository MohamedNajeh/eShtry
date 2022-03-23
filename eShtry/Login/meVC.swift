//
//  meVC.swift
//  FinalDemo
//
//  Created by Pola on 3/10/22.
//  Copyright © 2022 Pola. All rights reserved.
//

import UIKit


class meVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var moreOrdersArr : [OrdersTemp] = []
    var myOrder1 : OrdersTemp = OrdersTemp()
    var myOrder2 : OrdersTemp = OrdersTemp()
    
    @IBOutlet weak var welcomeUserLabelOtlet: UILabel!
    @IBOutlet weak var welcomeUserViewOutlet: UIView!
    @IBOutlet weak var loginViewOutlet: UIView!
    @IBOutlet weak var myOrdersViewOutlet: UIView!
    @IBOutlet weak var myWishListViewOutlet: UIView!
    @IBOutlet weak var logOutButtonOutlet: UIButton!
    @IBOutlet weak var stackViewLoggingIn: UIStackView!
    

    
    @IBOutlet weak var headerViewLoginLabel: UILabel!
    
    @IBOutlet weak var headerViewLoginBtn: UIButton!

    @IBOutlet weak var holderImgOrders: UIImageView!
    @IBOutlet weak var holderImgWishList: UIImageView!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var wishListTableView: UITableView!

    
    let userDefaults = UserDefaults.standard
    let coreData = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        moreOrdersArr.append(myOrder1)
//        moreOrdersArr.append(myOrder2)
        
    }
    
     override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        ifLogin()
           
        switch coreData.getAllFavoriteProducts().count {
        case 0:
            wishListTableView.isHidden=true
            holderImgWishList.isHidden=false
        case 0...:
            holderImgWishList.isHidden=true
            wishListTableView.isHidden=false
        default:
            print("")
        }
        
        wishListTableView.reloadData()
//         headerViewLoginLabel.text = "loginOrRegister".localized
//         headerViewLoginBtn.setTitle("loginOrRegisterBtn".localized, for: .normal)
        }
        


    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          if tableView == orderTableView{
              return 0
          }else if tableView == wishListTableView{
            return coreData.getAllFavoriteProducts().count
        }
        return 0
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == orderTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
            //let orderName = cell.viewWithTag(1) as? UILabel
            //let price = cell.viewWithTag(2) as? UILabel
            
            
            return cell
        }else if tableView == wishListTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "wishListCell", for: indexPath)
            let orderName = cell.viewWithTag(1) as? UILabel
            let img = cell.viewWithTag(2) as? UIImageView
            
            orderName?.text = coreData.getAllFavoriteProducts()[indexPath.row].name
            img?.setImage(with: coreData.getAllFavoriteProducts()[indexPath.row].imageUrl)

            return cell
        }

        return UITableViewCell()
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 70}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == wishListTableView{
            
            navigateToTabBarBYIndex(index: 2)
          }
    }
    
    @IBAction func loginRegister(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(loginVC, animated: true)
    }
    

    @IBAction func myAddressClick(_ sender: Any) {
        let addAddressVC = storyboard?.instantiateViewController(identifier: "AllAddressesVC") as! AllAddressesVC
        navigationController?.pushViewController(addAddressVC, animated: true)
    }
    
    
    @IBAction func myOrdersClick(_ sender: Any) {
        //navigateToTabBarBYIndex(index: <#T##Int#>)
    }
    
    
    @IBAction func myWishListClick(_ sender: Any) {
        navigateToTabBarBYIndex(index: 2)
    }
    
    @IBAction func profileClick(_ sender: Any) {
        let registerVC = storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterVC
        registerVC.checkWhichScreen="p"
        registerVC.userId = userDefaults.object(forKey: "userId") as? Int
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @IBAction func myCartClick(_ sender: Any) {
        navigateToTabBarBYIndex(index: 3)
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

        displayAlertTwoAction(title: "LOG OUT", message: "Are You Sure You Want To Log Out?", action: UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            self.userDefaults.set(false, forKey:"login")
            meVC.showToast(controller: self, message: "Loggedout".localized, seconds: 3)
            self.navigateToTabBarBYIndex(index: 0)
        }))
        

    }
    
    
    func ifLogin() {
        let userName = userDefaults.object(forKey: "userName") as? String ?? ""
        let isLoggedIn = userDefaults.object(forKey: "login") as? Bool ?? false

        if isLoggedIn {
            welcomeUserLabelOtlet.text = "\("Welcome".localized) \(userName)"
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
    
    func displayAlertTwoAction(title: String,message: String, action: UIAlertAction) {
        let alert = UIAlertController(title: title,message:message,preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel",style: .default, handler: nil))
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateToTabBarBYIndex(index : Int) {
        let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first
        let tabBarController = keyWindow?.rootViewController as! UITabBarController
        tabBarController.selectedIndex = index
        self.dismiss(animated: true, completion: {
            self.navigationController?.popToRootViewController(animated: false)
        })
    }
    
    func prepare() {
        
        //disAppear img
        holderImgOrders.isHidden=true
        holderImgWishList.isHidden=true
        
        //disAppear orders
        orderTableView.isHidden=true

        //Appear img
        holderImgOrders.isHidden=false
        holderImgWishList.isHidden=false
        
        //Appear orders
        orderTableView.isHidden=false

    }
}
