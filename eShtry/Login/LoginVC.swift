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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordOutletTF.isSecureTextEntry = true

        textFieldPlaceholder(textField: emailOutletTF, Placeholder: "Email Address")
        textFieldPlaceholder(textField: passwordOutletTF, Placeholder: "Password")

        continueOutletBtn?.isUserInteractionEnabled = false
        continueOutletBtn?.alpha = 0.5
    }
    

    @IBAction func continueClick(_ sender: Any) {
        if isValidPassword(password: passwordOutletTF.text!) == false{
           passwordOutletLabel.text = "Wrong password please try again"
        }
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
                emailOutletLabel.text = "Please enter an email address"
            }
        case passwordOutletTF:
            if !text.isEmpty {
                passwordOutletLabel.text = " "
            }else{
                passwordOutletLabel.text = "Please enter your Password"
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
    func isValidPassword(password: String) -> Bool {
        let passRegEx = "^(?=.*[a-z\\u0621-\\u064A])(?=.*[A-Z\\u0621-\\u064A])(?=.*[0-9\\u0660-\\u0669])[a-zA-Za-z\\u0621-\\u064A0-9\\u0660-\\u0669]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passwordTest.evaluate(with: password)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @IBAction func eyeShowPassword(_ sender: Any) {
        let pass = passwordOutletTF.text ?? ""
        if eyeOutletBtn.currentImage == UIImage(systemName:"eye.slash") {
            eyeOutletBtn.setImage(UIImage(systemName:"eye"), for: .normal)
            passwordOutletTF.isSecureTextEntry = true
            if passwordOutletTF.text?.count ?? -1>0 {
                passwordOutletTF.insertText(pass)
            }
        }else {
            eyeOutletBtn.setImage(UIImage(systemName:"eye.slash"), for: .normal)
            passwordOutletTF.isSecureTextEntry = false
        }
    }

    @IBAction func register(_ sender: Any) {
        let registerVC = storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterVC
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func textFieldPlaceholder(textField : UITextField, Placeholder : String) {
        textField.attributedPlaceholder = NSAttributedString(
              string: Placeholder,
              attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 90/255, blue: 167/255, alpha: 1.0)]
          )
    }
    
}
