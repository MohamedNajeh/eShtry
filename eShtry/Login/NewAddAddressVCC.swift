//
//  AddAddressVC.swift
//  eShtry
//
//  Created by Pola on 3/19/22.
//

import UIKit

class NewAddAddressVCC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var imageNoAddressesOutlet: UIImageView!
    @IBOutlet weak var titleScreenAddressesOutlet: UILabel!
    @IBOutlet weak var addresseTableOutlet: UITableView!
    
    let networkShared = NetworkManager.shared
    let userDefaults = UserDefaults.standard
    var userId = 0
    var addressId = 0
    var allAddressesApi : [Addresses] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addresseTableOutlet.tableFooterView = UIView()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userId = userDefaults.object(forKey: "userId") as? Int ?? 0
        print(userId)
        networkShared.getDataFromApi(urlString: allAddresses(userId: userId), baseModel: AddressesRoot.self) { (result) in
            switch result {
            case .success(let data):
                if let allAdds = data.addresses {
                    print(allAdds)
                    self.allAddressesApi = allAdds
                }
                DispatchQueue.main.async {
                    if self.allAddressesApi.count == 0 {
                        self.imageNoAddressesOutlet.isHidden=false
                    } else {
                        self.imageNoAddressesOutlet.isHidden=true
                    }
                    self.addresseTableOutlet.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @IBAction func addNewAddress(_ sender: Any) {
        let addressVC = storyboard?.instantiateViewController(identifier: "AddressVC") as! AddressVC
        navigationController?.pushViewController(addressVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return allAddressesApi.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
        
        let title = cell.viewWithTag(1) as? UILabel
        let name = cell.viewWithTag(2) as? UILabel
        let phone = cell.viewWithTag(3) as? UILabel
        let cityCountry = cell.viewWithTag(4) as? UILabel
        let address = cell.viewWithTag(5) as? UILabel
        if let selectBtn : UIButton = cell.viewWithTag(6) as? UIButton{
            selectBtn.tag = indexPath.row
            selectBtn.addTarget(self, action: #selector(editAddress(sender:)), for: .touchUpInside)
        }
        
        
        title?.text = "\(allAddressesApi[indexPath.row].address2 ?? "") \(allAddressesApi[indexPath.row].province ?? "")"
        name?.text = allAddressesApi[indexPath.row].name
        phone?.text = allAddressesApi[indexPath.row].phone
        cityCountry?.text = "\(allAddressesApi[indexPath.row].city ?? ""), \(allAddressesApi[indexPath.row].country ?? "")"
        address?.text = allAddressesApi[indexPath.row].address1
        
        return cell
    }
    
    @objc func editAddress(sender : UIButton)  {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {return 190}
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Alert",message:"Are You Sure to delete this address?",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel",style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
                
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

            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
