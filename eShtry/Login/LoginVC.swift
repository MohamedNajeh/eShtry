//
//  LoginVC.swift
//  FinalDemo
//
//  Created by Pola on 3/10/22.
//  Copyright © 2022 Pola. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailOutletTF: UITextField!
    @IBOutlet weak var passwordOutletTF: UITextField!
    
    @IBOutlet weak var eyeOutletBtn: UIButton!
    @IBOutlet weak var continueOutletBtn: UIButton!
    
    @IBOutlet weak var emailOutletLabel: UILabel!
    @IBOutlet weak var passwordOutletLabel: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginToYourAccountLabel: UILabel!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    let networkShared = NetworkManager.shared
    var isValidLogin = false
    let activityIndecator = UIActivityIndicatorView(style:.large)
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        passwordOutletTF.isSecureTextEntry = true
        
        textFieldPlaceholder(textField: emailOutletTF, Placeholder: "Email Address".localized)
        textFieldPlaceholder(textField: passwordOutletTF, Placeholder: "Password".localized)
        
        continueOutletBtn?.isUserInteractionEnabled = false
        continueOutletBtn?.alpha = 0.5
        continueOutletBtn.setTitle("continue".localized, for: .normal)
        
        loginToYourAccountLabel.text = "loginToYourAccountLabel".localized
        
        registerBtn.setTitle("register".localized, for: .normal)
        dontHaveAccountLabel.text = "dontHaveAccountLabel".localized
    }
    
    
    @IBAction func continueClick(_ sender: Any) {
        let myEmail = emailOutletTF.text ?? ""
        let myPassword = passwordOutletTF.text ?? ""
        
        if isValidPassword(password: myPassword) == false{
            passwordOutletLabel.text = "Wrong password please try again".localized
        }else{
            self.activityIndicatorLoading()
            networkShared.login(email: myEmail, password: myPassword) { [weak self] (response) in
                
                switch response.result{
                case .success(_):
                    guard let responseObject = response.value else {return}
                    let customersList = responseObject.customers
                    for customer in customersList {
                        let comingMail = customer.email ?? ""
                        let comingPassword = customer.tags ?? ""
                        if comingMail == myEmail && comingPassword == myPassword {
                            print("found")
                            
                            self?.userDefaults.set(customer.id, forKey: "userId")
                            self?.userDefaults.set(true, forKey: "login")
                            self?.userDefaults.set(customer.first_name, forKey: "userName")
                            DispatchQueue.main.async {
                                self!.activityIndecator.stopAnimating()
                            }
                
                            self?.isValidLogin = true
                            break
                        }
                    }
                case .failure(let error):
                    print(error)
                }
                
                if self?.isValidLogin == false {
                    self!.activityIndecator.stopAnimating()
                    LoginVC.presentAlert(controller: self!, title: "Wrong Login!".localized, message: "Check your email or password and try logging in again".localized, style: .alert, actionTitle: "OK".localized) { (action) in
                        self?.dismiss(animated: true, completion: nil)
                    }
                }else{

                    LoginVC.showToast(controller: self!, message: "Login Succeeded".localized, seconds: 3)

                    self?.navigateToMain()
                }
            }
        }
    }
    
    
    @IBAction func eyeShowPassword(_ sender: Any) {
        let pass = passwordOutletTF.text ?? ""
        if eyeOutletBtn.currentImage == UIImage(systemName:"eye") {
            eyeOutletBtn.setImage(UIImage(systemName:"eye.slash"), for: .normal)
            passwordOutletTF.isSecureTextEntry = true
            if passwordOutletTF.text?.count ?? -1>0 {
                passwordOutletTF.insertText(pass)
            }
        }else {
            eyeOutletBtn.setImage(UIImage(systemName:"eye"), for: .normal)
            passwordOutletTF.isSecureTextEntry = false
        }
    }
    
    @IBAction func navigateToRegisterScreen(_ sender: Any) {
        let registerVC = storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterVC
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        switch textField {
        case emailOutletTF:
            if !text.isEmpty {
                emailOutletLabel.text = " "
                if isValidEmail(text) == false {
                    emailOutletLabel.text = "   "
                }
            }else{
                emailOutletLabel.text = "Please enter an email address".localized
            }
        case passwordOutletTF:
            if !text.isEmpty {
                passwordOutletLabel.text = " "
            }else{
                passwordOutletLabel.text = "Please enter your Password".localized
            }
            
        default:
            textField.text=""
        }
        
        validationUserInput()
        
        return true
    }
    
    func validationUserInput() {
        if (emailOutletLabel.text    == " " &&
            passwordOutletLabel.text == " ")
        {
            continueOutletBtn.isUserInteractionEnabled = true
            continueOutletBtn?.alpha = 1.0
        }
        else{
            continueOutletBtn?.isUserInteractionEnabled = false
            continueOutletBtn?.alpha = 0.5
        }
    }
    
    func activityIndicatorLoading() { // loading...
        activityIndecator.center = view.center
        view.addSubview(activityIndecator)
        activityIndecator.startAnimating()
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
