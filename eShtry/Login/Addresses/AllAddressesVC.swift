//
//  AllAddressesVC.swift
//  eShtry
//
//  Created by Pola on 3/20/22.
//

import UIKit

class AllAddressesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var imageNoAddressesOutlet: UIImageView!
    @IBOutlet weak var titleScreenAddressesOutlet: UILabel!
    @IBOutlet weak var addressTableOutlet: UITableView!
    
    let activityIndecator = UIActivityIndicatorView(style:.large)
    let networkShared = NetworkManager.shared
    let userDefaults = UserDefaults.standard
    var userId = 0
    var addressId = 0
    var allAddressesApi : [Addresses] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        addressTableOutlet.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userId = userDefaults.object(forKey: "userId") as? Int ?? 0
        
        activityIndicatorLoading()
        networkShared.getDataFromApi(urlString: allAddresses(userId: userId), baseModel: AddressesRoot.self) { (result) in
            switch result {
            case .success(let data):
                if let allAdds = data.addresses {
                    //print(allAdds)
                    self.allAddressesApi = allAdds
                }
                DispatchQueue.main.async {
                    if self.allAddressesApi.count == 0 {
                        self.imageNoAddressesOutlet.isHidden=false
                        self.titleScreenAddressesOutlet.isHidden=true
                    } else {
                        self.imageNoAddressesOutlet.isHidden=true
                        self.titleScreenAddressesOutlet.isHidden=false
                    }
                    self.addressTableOutlet.reloadData()
                    self.activityIndecator.stopAnimating()
                }
//                DispatchQueue.main.async {
//                    if !self.allAddressesApi.isEmpty{
//
//                    }
//                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    @IBAction func addNewAddress(_ sender: Any) {
        let addressVC = storyboard?.instantiateViewController(identifier: "AddressVC") as! AddressVC
        navigationController?.pushViewController(addressVC, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAddressesApi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
        
        let title = cell.viewWithTag(1) as? UILabel
        let name = cell.viewWithTag(2) as? UILabel
        let phone = cell.viewWithTag(3) as? UILabel
        let cityCountry = cell.viewWithTag(4) as? UILabel
        let address = cell.viewWithTag(5) as? UILabel

     
        self.allAddressesApi[0].address2?.append(" (Default)")
        title?.text = allAddressesApi[indexPath.row].address2
        name?.text = allAddressesApi[indexPath.row].name
        phone?.text = allAddressesApi[indexPath.row].phone
        cityCountry?.text = "\(allAddressesApi[indexPath.row].city ?? "") , \(allAddressesApi[indexPath.row].country ?? "")"
        address?.text = allAddressesApi[indexPath.row].address1
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {return 185}
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if indexPath.row == 0 {
                displayAlert(title: "DELETE", message: "You Can't Delete This Address")
            }else{
                displayAlertTwoAction(title: "DELETE", message: "Are You Sure You Want To Delete This Address?", action: UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
                    
                    tableView.beginUpdates()
                    tableView.deleteRows(at:[indexPath], with: .automatic)
                    
                    self.addressId = self.allAddressesApi[indexPath.row].id
                    self.allAddressesApi.remove(at: indexPath.row)
                    self.networkShared.deleteAddress(userId: self.userId, addressId: self.addressId) { (data, response, error) in
                        let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String,Any>
                        if json.isEmpty {
                            print("deleted")
                        }else{
                            print("cant delete")
                        }
                    }
                    
                    tableView.endUpdates()
                    tableView.reloadData()
                    
                    if self.allAddressesApi.count==0 {
                        self.imageNoAddressesOutlet.isHidden=false
                    } else {
                        self.imageNoAddressesOutlet.isHidden=true
                    }
                    
                }))
                
            }
        }
    }
    
    
    func displayAlertTwoAction(title: String,message: String, action: UIAlertAction) {
        let alert = UIAlertController(title: title,message:message,preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel",style: .default, handler: nil))
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    func displayAlert(title: String,message: String) {
        let alert = UIAlertController(title: title,message:message,preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func activityIndicatorLoading() { // loading...
        activityIndecator.center = view.center
        view.addSubview(activityIndecator)
        activityIndecator.startAnimating()
    }
}
