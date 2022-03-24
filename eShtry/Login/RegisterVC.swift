//
//  RegisterVC.swift
//  FinalDemo
//
//  Created by Pola on 3/10/22.
//  Copyright © 2022 Pola. All rights reserved.
//

import UIKit

class RegisterVC: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var mobileNumTF: UITextField!
    @IBOutlet weak var emailAddressTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var dateOfBirthTF: UITextField!
    @IBOutlet weak var eyeButtonOutLet: UIButton!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var registerBtnOutlet: UIButton!
    
    @IBOutlet weak var welcomeUserProfile: UILabel!
    @IBOutlet weak var firstNameProfile: UILabel!
    @IBOutlet weak var lastNameProfile: UILabel!
    @IBOutlet weak var mobileNumProfile: UILabel!
    @IBOutlet weak var emailProfile: UILabel!
    @IBOutlet weak var dateProfile: UILabel!
    @IBOutlet weak var passwordStackProfile: UIStackView!
    
    @IBOutlet weak var createNewAccountLabel: UILabel!
    var checkWhichScreen : Character = "r"
    var userId : Int?
    let networkShared = NetworkManager.shared
    
    private var datePicker : UIDatePicker?
    let dateFormatter = DateFormatter()
    let userDefaults = UserDefaults.standard
    let activityIndecator = UIActivityIndicatorView(style:.large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        if checkWhichScreen == "p" {
            translateToArabic()
            registerBtnOutlet.setTitle("Back".localized, for: .normal)
            activityIndicatorLoading()
            networkShared.getDataFromApi(urlString: customerById(userId: userId ?? 0), baseModel: CustomarRoot.self) { (result) in
                switch result {
                case .success(let data):
 
                    DispatchQueue.main.async {
                        self.appeareProfileLabels(firstName:data.customer?.first_name ?? "", lastName: data.customer?.last_name ?? "", email: data.customer?.email ?? "", mobile: data.customer?.phone ?? "", date: data.customer?.note ?? "")
                        self.activityIndecator.stopAnimating()
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }

        }else{
            passwordTF.isSecureTextEntry = true
            passwordLabel.text = "Minimum of 8 characters with at least 1 uppercase, 1 lowercase, and 1 number".localized
            createNewAccountLabel.text = "createNewAccount".localized

            textFieldPlaceholder(textField: firstNameTF, Placeholder: "First Name".localized)
            textFieldPlaceholder(textField: lastNameTF, Placeholder: "Last Name".localized)
            textFieldPlaceholder(textField: mobileNumTF, Placeholder: "Mobile Number".localized)
            textFieldPlaceholder(textField: emailAddressTF, Placeholder: "Email Address".localized)
            textFieldPlaceholder(textField: passwordTF, Placeholder: "Password".localized)
            textFieldPlaceholder(textField: dateOfBirthTF, Placeholder: "Date of Birth".localized)
            
            registerBtnOutlet?.isUserInteractionEnabled = false
            registerBtnOutlet?.alpha = 0.5
        }
        
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        ConfigurationDatePicker()
    }
    

    
    @IBAction func register(_ sender: Any) {
        if checkWhichScreen == "p" {
            self.navigationController?.popViewController(animated: true)
        }else{
            
            let customer = Customer(first_name: firstNameTF.text, last_name: lastNameTF.text, email: emailAddressTF.text, phone: mobileNumTF.text,tags: passwordTF.text, note: dateOfBirthTF.text, id: nil, verified_email: true, addresses: nil)
            
            let newCustomer = CustomarRoot(customer: customer)
            registerCustomer(newCustomer:newCustomer)
        
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        switch textField {
        case firstNameTF:
            if !text.isEmpty {
                firstNameLabel.text = " "
            }else{
                firstNameLabel.text = "Please enter your first name".localized
            }
        case lastNameTF:
            if !text.isEmpty {
                lastNameLabel.text = " "
            }else {
                lastNameLabel.text = "Please enter your last name".localized
            }
        case mobileNumTF:
            if !text.isEmpty {
                phoneNumLabel.text = " "
                if isValidPhoneNumber(phoneNumber: text) == false{
                    phoneNumLabel.text = "Please enter a valid phone number!".localized
                }
            }else{
                phoneNumLabel.text = "Please enter a phone number".localized
            }
        case emailAddressTF:
            if !text.isEmpty {
                emailAddressLabel.text = " "
                if isValidEmail(text) == false {
                    emailAddressLabel.text = "Please enter a valid email address".localized
                }
            }else{
                emailAddressLabel.text = "Please enter an email address".localized
            }
        case passwordTF:
            if !text.isEmpty {
                passwordLabel.text = " "
                if isValidPassword(password: text) == false{
                    passwordLabel.text = "Weak Password!. Minimum of 8 characters with at least 1 uppercase, 1 lowercase, and 1 number".localized
                    passwordLabel.textColor = .red
                }
            }else{
                passwordLabel.text = "Minimum of 8 characters with at least 1 uppercase, 1 lowercase, and 1 number".localized
                passwordLabel.textColor = .gray
            }
        case dateOfBirthTF:
            if !text.isEmpty {
                if text != dateFormatter.string(from: datePicker!.date) {
                    dateOfBirthTF.text = ""
                    dateOfBirthLabel.text = "Please select your date of birth".localized
                }
            }else{
                dateOfBirthLabel.text = "Please select your date of birth".localized
            }
            
        default:
            textField.text = ""
        }
        
        validationUserInput()
        return true
    }
    
    
    
    
    func validationUserInput() {
        if (firstNameLabel.text    == " " &&
            lastNameLabel.text     == " " &&
            phoneNumLabel.text     == " " &&
            emailAddressLabel.text == " " &&
            passwordLabel.text     == " " &&
            dateOfBirthLabel.text  == " ")
        {
            registerBtnOutlet.isUserInteractionEnabled = true
            registerBtnOutlet?.alpha = 1.0
        }
        else{
            registerBtnOutlet?.isUserInteractionEnabled = false
            registerBtnOutlet?.alpha = 0.5
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
    
    
    func ConfigurationDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker?.maximumDate = NSDate() as Date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        let toolBar = UIToolbar()
        let btnDone = UIBarButtonItem(title: "OK".localized, style: .plain, target: self, action: #selector(closePicker))
        toolBar.setItems([btnDone], animated: true)
        
        dateOfBirthTF.inputAccessoryView = toolBar
        dateOfBirthTF.inputView = datePicker
        toolBar.sizeToFit()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func closePicker(){ view.endEditing(true) }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true) }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "MM/dd/yyyy"
        dateOfBirthTF.text = dateFormatter.string(from: datePicker.date)
        dateOfBirthLabel.text = " "
        validationUserInput()
    }
    
    func appeareProfileLabels(firstName:String,lastName:String,email:String,mobile:String,date:String) {
        welcomeUserProfile.text="Your Profile".localized
        firstNameProfile.isHidden=false
        lastNameProfile.isHidden=false
        mobileNumProfile.isHidden=false
        emailProfile.isHidden=false
        dateProfile.isHidden=false
        passwordStackProfile.isHidden=true
        
        firstNameTF.text=firstName
        lastNameTF.text=lastName
        mobileNumTF.text=mobile
        emailAddressTF.text=email
        dateOfBirthTF.text=date
        firstNameTF.isUserInteractionEnabled = false
        lastNameTF.isUserInteractionEnabled = false
        mobileNumTF.isUserInteractionEnabled = false
        emailAddressTF.isUserInteractionEnabled = false
        dateOfBirthTF.isUserInteractionEnabled = false
    }
    
    func registerCustomer(newCustomer:CustomarRoot){
        activityIndicatorLoading()
        networkShared.registerCustomer(newCustomer:newCustomer){ [weak self] (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let data = data {
                    print(data)
                    let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
                    print(json)
                    let returnedCustomer = json["customer"] as? Dictionary<String,Any>
                    let id = returnedCustomer?["id"] as? Int ?? 0
                    let name = returnedCustomer?["first_name"] as? String ?? ""
                    print(returnedCustomer ?? "")
                    print(id)
                    if id != 0 {
                        print("name: \(name)")
                        self?.userDefaults.set(id, forKey: "userId")
                        self?.userDefaults.set(true, forKey: "login")
                        self?.userDefaults.set(name, forKey: "userName")
                        DispatchQueue.main.async {
                            self?.activityIndecator.stopAnimating()
                            RegisterVC.showToast(controller: self!, message: "Registered Successfully".localized, seconds: 3)
                            self?.navigateToMain()
                        }
                        
                        print("registered successfully")
                    }else{
                        DispatchQueue.main.async {
                            RegisterVC.presentAlert(controller: self!, title: "Registration error".localized, message: "Make sure you enter your Email correctly".localized, style: .alert, actionTitle: "OK") { (action) in
                                self?.dismiss(animated: true, completion: nil)
                            }
                        }
                        
                        print("An error occurred while registering")
                    }
                }
            }
        }
    }
    
    @IBAction func eyeShowPassword(_ sender: Any) {
        let pass = passwordTF.text ?? ""
        if eyeButtonOutLet.currentImage == UIImage(systemName:"eye") {
            eyeButtonOutLet.setImage(UIImage(systemName:"eye.slash"), for: .normal)
            passwordTF.isSecureTextEntry = true
            if passwordTF.text?.count ?? -1>0 {
                passwordTF.insertText(pass)
            }
        }else {
            eyeButtonOutLet.setImage(UIImage(systemName:"eye"), for: .normal)
            passwordTF.isSecureTextEntry = false
        }
    }
    
    func activityIndicatorLoading() { // loading...
        activityIndecator.center = view.center
        view.addSubview(activityIndecator)
        activityIndecator.startAnimating()
    }
    
    func translateToArabic(){
        firstNameProfile.text = "First Name".localized
        lastNameProfile.text  = "Last Name".localized
        mobileNumProfile.text = "Mobile Number".localized
        emailProfile.text     = "Email Address".localized
        dateProfile.text      = "Date of Birth".localized
        
    }
}


