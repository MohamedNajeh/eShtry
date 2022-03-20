//
//  CartVC.swift
//  FinalDemo
//
//  Created by Pola on 3/10/22.
//  Copyright © 2022 Pola. All rights reserved.
//

import UIKit

class AddressVC: UIViewController, setCountryProtocol, UITextFieldDelegate {

    @IBOutlet weak var stackCustomAddressTitle: UIStackView!
    @IBOutlet weak var flagOutletImage: UIImageView!
    
    @IBOutlet weak var countryOutletLabel: UILabel!
    @IBOutlet weak var cityOutletLabel: UILabel!
    @IBOutlet weak var addressOutletTF: UITextField!
    @IBOutlet weak var zipCodeOutletTF: UITextField!
    @IBOutlet weak var customAddressTitleTF: UITextField!
    @IBOutlet weak var receiverNameOutletTF: UITextField!
    @IBOutlet weak var receiverPhoneOutletTF: UITextField!

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var receiverPhoneLabel: UILabel!
    @IBOutlet weak var receiverNameLabel: UILabel!
    
    @IBOutlet weak var changeCityOutletButton: UIButton!
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    let userDefaults = UserDefaults.standard
    let networkShared = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButtonOutlet?.isUserInteractionEnabled = false
        confirmButtonOutlet?.alpha = 0.5
        
        
        textFieldPlaceholder(textField: addressOutletTF, Placeholder: "Address")
        textFieldPlaceholder(textField: zipCodeOutletTF, Placeholder: "Zip / Postal code")
        textFieldPlaceholder(textField: receiverNameOutletTF, Placeholder: "Receiver Name")
        textFieldPlaceholder(textField: receiverPhoneOutletTF, Placeholder: "Mobile Number")
        textFieldPlaceholder(textField: customAddressTitleTF, Placeholder: "Custom Address Label")
        
//        countryOutletLabel.text = defaults.object(forKey: "country") as? String ?? "Select Country"
//        flagOutletImage.image = UIImage(named: defaults.object(forKey: "country") as? String ?? "global")
//        cityOutletLabel.text = defaults.object(forKey: "city") as? String ?? "Select City"
//        addressOutletTF.text = defaults.object(forKey: "address") as? String ?? ""
//        zipCodeOutletTF.text = defaults.object(forKey: "zipCode") as? String ?? ""
        
        
        if countryOutletLabel.text != "Select Country" {
            changeCityOutletButton?.isUserInteractionEnabled = true
            changeCityOutletButton?.alpha = 1.0
        }else {
            changeCityOutletButton?.isUserInteractionEnabled = false
            changeCityOutletButton?.alpha = 0.5
        }
    }
    
    
    @IBAction func confirmAddressClick(_ sender: Any) {
//        defaults.set(addressOutletTF.text, forKey: "address")
//        defaults.set(zipCodeOutletTF.text, forKey: "zipCode")
//        defaults.set(countryOutletLabel.text, forKey: "country")
//        defaults.set(cityOutletLabel.text, forKey: "city")
        
        let address = Addresses(address1: addressOutletTF.text, city: cityOutletLabel.text, province: "", phone: receiverPhoneOutletTF.text, zip: zipCodeOutletTF.text, name: receiverNameOutletTF.text, country: countryOutletLabel.text)
        addAddress(address: address)
        
        
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func addressTitleChoose(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            print(segmentControl.titleForSegment(at: 0) ?? "")
            stackCustomAddressTitle.isHidden = true
        case 1:
            print(segmentControl.titleForSegment(at: 1) ?? "")
            stackCustomAddressTitle.isHidden = true
        case 2:
            print(segmentControl.titleForSegment(at: 2) ?? "")
            stackCustomAddressTitle.isHidden = false
//            customAddressTitleTF.text
        default:
            print("")
        }

    }
    
    @IBAction func defaultAddress(_ sender: UISwitch) {
        print("state = \(sender.isOn)")
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
                addressLabel.text = " "
            }else{
                addressLabel.text = "Please enter your address"
            }
        case zipCodeOutletTF:
            if !text.isEmpty {
               zipCodeLabel.text = " "
                if isValidZipCode(zipCode: text) == false {
                    zipCodeLabel.text = "Please enter valid zip / postal code"
                }
            }else{
               zipCodeLabel.text = "Please enter your zip / postal code"
            }
        case receiverNameOutletTF:
            if !text.isEmpty {
                receiverNameLabel.text = " "
            }else{
                receiverNameLabel.text = "Please enter a receiver name"
            }
        case receiverPhoneOutletTF:
            if !text.isEmpty {
                receiverPhoneLabel.text = " "
                if isValidPhoneNumber(phoneNumber: text) == false{
                    receiverPhoneLabel.text = "Please enter a valid phone number !!"
                }
            }else{
                receiverPhoneLabel.text = "Please enter a receiver mobile number"
            }
        default:
            textField.text = ""
        }

       validationUserInput()
        return true
    }
    
    
    func validationUserInput() {
        if addressLabel.text == " " && zipCodeLabel.text == " " && receiverNameLabel.text == " " && receiverPhoneLabel.text == " " && countryOutletLabel.text != "Select Country" && cityOutletLabel.text != "Select City" {
            confirmButtonOutlet?.isUserInteractionEnabled = true
            confirmButtonOutlet?.alpha = 1.0
        }else {
            confirmButtonOutlet?.isUserInteractionEnabled = false
            confirmButtonOutlet?.alpha = 0.5
        }
    }
    
    

    func addAddress(address: Addresses){
            let id = userDefaults.object(forKey: "userId") as? Int ?? 0
            var newAddress = address
            networkShared.addAddress(id: id, address: address) { [weak self] (data, response, error) in
                if error != nil {
                    print("error while adding address \(error!)")
                    return
                }
                if let data = data{
                    print("data: \(data)")
                    let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
                    print("json: \(json)")
                    let returnedCustomer = json["customer"] as? Dictionary<String,Any>
                    do{
                        let returnedCust = try JSONDecoder().decode(CustomarRoot.self, from: data)
                        
                        print("***********")
                        print("result customer \(String(describing: returnedCust))")
                        print("***********")
                        print("new address id \(String(describing: returnedCust.customer?.addresses?.last?.id ?? 0))")
                        print("***********")
                        newAddress.id = returnedCust.customer?.addresses?.last?.id ?? 0
                    }catch{
                        print("could parse response: \(error.localizedDescription)")
                    }
                    let id = returnedCustomer?["id"] as? Int ?? 0
    //                let addresses = returnedCustomer?["addresses"] as? Int ?? 0
                    if id == 0 {
                        self?.displayAlert(title: "user not supported", message: "An error occured while adding your address")
                    }else {
                        NewAddAddress.showToast(controller: self!, message: "successful added new address", seconds: 3)
                    }
                }
            }
        }
    
    func displayAlert(title: String,message: String) {
        let alert = UIAlertController(title: title,message:message,preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
