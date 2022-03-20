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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addresseTableOutlet.tableFooterView = UIView()
    }
    

    @IBAction func addNewAddress(_ sender: Any) {
        let addressVC = storyboard?.instantiateViewController(identifier: "AddressVC") as! AddressVC
        navigationController?.pushViewController(addressVC, animated: true)
    }
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 2}
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
//        let title = cell.viewWithTag(1) as? UILabel
//        let name = cell.viewWithTag(2) as? UILabel
//        let phone = cell.viewWithTag(3) as? UILabel
//        let cityCountry = cell.viewWithTag(4) as? UILabel
//        let address = cell.viewWithTag(5) as? UILabel

        return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {return 200}
}
