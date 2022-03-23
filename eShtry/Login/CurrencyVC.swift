//
//  CurrencyVC.swift
//  eShtry
//
//  Created by Pola on 3/16/22.
//

import UIKit

class CurrencyVC: UIViewController,setCountryProtocol {
    
    @IBOutlet weak var currencyOutletLabel: UILabel!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
      currencyOutletLabel.text = defaults.object(forKey: "currency") as? String ?? "Select Currency"
    }
    
    
    func sendCountry(name: String, whichScreen: Character) {
        currencyOutletLabel.text = name
        defaults.set(name, forKey: "currency")
    }
    
    @IBAction func changeCurrency(_ sender: Any) {
        let countryVC = storyboard?.instantiateViewController(identifier: "CountryVC") as! CountryVC
        countryVC.checkWhichTable = "2"
        countryVC.myCountryProtocol = self
        self.present(countryVC, animated: true, completion: nil)
        
    }
    
    
}
