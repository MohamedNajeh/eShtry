//
//  CartVC.swift
//  FinalDemo
//
//  Created by Pola on 3/10/22.
//  Copyright © 2022 Pola. All rights reserved.
//

import UIKit

class AddressVC: UIViewController, setCountryProtocol, UITextFieldDelegate {

    @IBOutlet weak var countryOutletLabel: UILabel!
    @IBOutlet weak var cityOutletLabel: UILabel!
    @IBOutlet weak var flagOutletImage: UIImageView!
    @IBOutlet weak var addressOutletTF: UITextField!
    @IBOutlet weak var zipCodeOutletTF: UITextField!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    
    @IBOutlet weak var changeCityOutletButton: UIButton!
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButtonOutlet?.isUserInteractionEnabled = false
        confirmButtonOutlet?.alpha = 0.5
        
        countryOutletLabel.text = defaults.object(forKey: "country") as? String ?? "Select Country"
        flagOutletImage.image = UIImage(named: defaults.object(forKey: "country") as? String ?? "global")
        cityOutletLabel.text = defaults.object(forKey: "city") as? String ?? "Select City"
        addressOutletTF.text = defaults.object(forKey: "address") as? String ?? ""
        zipCodeOutletTF.text = defaults.object(forKey: "zipCode") as? String ?? ""
        
        
        if countryOutletLabel.text != "Select Country" {
            changeCityOutletButton?.isUserInteractionEnabled = true
            changeCityOutletButton?.alpha = 1.0
        }else {
            changeCityOutletButton?.isUserInteractionEnabled = false
            changeCityOutletButton?.alpha = 0.5
        }
    }


    func sendCountry(name: String, whichScreen: Character) {
        if whichScreen == "0"{
            countryOutletLabel.text = name
            flagOutletImage.image = UIImage(named: name)
        }else{
            cityOutletLabel.text = name
        }
        if countryOutletLabel.text != "Select Country" {
            changeCityOutletButton?.isUserInteractionEnabled = true
            changeCityOutletButton?.alpha = 1.0
        }else {
            changeCityOutletButton?.isUserInteractionEnabled = false
            changeCityOutletButton?.alpha = 0.5
        }
        validationUserInput()
        
    }
    
    @IBAction func changeCountryClick(_ sender: Any) {
        let countryVC = storyboard?.instantiateViewController(identifier: "CountryVC") as! CountryVC
        countryVC.checkWhichTable = "0"
        countryVC.myCountryProtocol = self
        self.present(countryVC, animated: true, completion: nil)
    }
    
    
    @IBAction func changeCity(_ sender: Any) {
        let countryVC = storyboard?.instantiateViewController(identifier: "CountryVC") as! CountryVC
         countryVC.checkWhichTable = "1"
        countryVC.myCountryProtocol = self
        self.present(countryVC, animated: true, completion: nil)
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        switch textField {
        case addressOutletTF:
            if !text.isEmpty {
                if !(zipCodeOutletTF.text?.isEmpty ?? false) {
                    zipCodeLabel.text = " "
                }
                addressLabel.text = " "
            }else{
                addressLabel.text = "Please enter your address"
            }
        case zipCodeOutletTF:
            if !text.isEmpty {
                if !(addressOutletTF.text?.isEmpty ?? false) {
                    addressLabel.text = " "
                }
               zipCodeLabel.text = " "
                
            }else{
               zipCodeLabel.text = "Please enter your zip / postal code"
            }
            
        default:
            textField.text = ""
        }

       validationUserInput()
        return true
    }
    
    @IBAction func confirmAddressClick(_ sender: Any) {
        defaults.set(addressOutletTF.text, forKey: "address")
        defaults.set(zipCodeOutletTF.text, forKey: "zipCode")
        defaults.set(countryOutletLabel.text, forKey: "country")
        defaults.set(cityOutletLabel.text, forKey: "city")
        
        navigationController?.popViewController(animated: true)
    }
    
    func validationUserInput() {
        if addressLabel.text == " " && zipCodeLabel.text == " " && countryOutletLabel.text != "Select Country" && cityOutletLabel.text != "Select City" {
            confirmButtonOutlet?.isUserInteractionEnabled = true
            confirmButtonOutlet?.alpha = 1.0
        }else {
            confirmButtonOutlet?.isUserInteractionEnabled = false
            confirmButtonOutlet?.alpha = 0.5
        }
    }
}
