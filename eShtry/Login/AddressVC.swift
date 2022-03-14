//
//  CartVC.swift
//  FinalDemo
//
//  Created by Pola on 3/10/22.
//  Copyright © 2022 Pola. All rights reserved.
//

import UIKit

class AddressVC: UIViewController, setCountryProtocol {

    @IBOutlet weak var countryOutletLabel: UILabel!
    @IBOutlet weak var flagOutletImage: UIImageView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryOutletLabel.text = defaults.object(forKey: "name") as? String ?? "Select Country"
        flagOutletImage.image = UIImage(named:  defaults.object(forKey: "name") as? String ?? "")
        
    }



    func sendCountry(name: String) {
        countryOutletLabel.text = name
        flagOutletImage.image = UIImage(named: name)
        defaults.set(name, forKey: "name")
    }
    
    @IBAction func changeCountryClick(_ sender: Any) {
        let countryVC = storyboard?.instantiateViewController(identifier: "CountryVC") as! CountryVC
        countryVC.myCountryProtocol = self
        self.present(countryVC, animated: true, completion: nil)
    }
    
    @IBAction func confirmAddressClick(_ sender: Any) {
      
        navigationController?.popViewController(animated: true)
    }
}
