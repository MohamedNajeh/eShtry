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
    
    var checkWhichScreen : Character = "r"
    
    private var datePicker : UIDatePicker?
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if checkWhichScreen == "p" {
            appeareProfileLabels(firstName: " ", lastName: " ", email: " ", mobile: " ", date: " ")
        }else{
            passwordTF.isSecureTextEntry = true
            
            textFieldPlaceholder(textField: firstNameTF, Placeholder: "First Name")
            textFieldPlaceholder(textField: lastNameTF, Placeholder: "Last Name")
            textFieldPlaceholder(textField: mobileNumTF, Placeholder: "Mobile Number")
            textFieldPlaceholder(textField: emailAddressTF, Placeholder: "Email Address")
            textFieldPlaceholder(textField: passwordTF, Placeholder: "Password")
            textFieldPlaceholder(textField: dateOfBirthTF, Placeholder: "Date of Birth")
            
            registerBtnOutlet?.isUserInteractionEnabled = false
            registerBtnOutlet?.alpha = 0.5
        }

        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        ConfigurationDatePicker()
    }
    
    
    
    @IBAction func eyeShowPassword(_ sender: Any) {
        let pass = passwordTF.text ?? ""
        if eyeButtonOutLet.currentImage == UIImage(systemName:"eye.slash") {
            eyeButtonOutLet.setImage(UIImage(systemName:"eye"), for: .normal)
            passwordTF.isSecureTextEntry = true
            if passwordTF.text?.count ?? -1>0 {
                passwordTF.insertText(pass)
            }
        }else {
            eyeButtonOutLet.setImage(UIImage(systemName:"eye.slash"), for: .normal)
            passwordTF.isSecureTextEntry = false
        }
    }
    

    @IBAction func register(_ sender: Any) {
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        switch textField {
        case firstNameTF:
            if !text.isEmpty {
                firstNameLabel.text = " "
            }else{
                firstNameLabel.text = "Please enter your first name"
            }
        case lastNameTF:
            if !text.isEmpty {
                lastNameLabel.text = " "
            }else {
                lastNameLabel.text = "Please enter your last name"
            }
        case mobileNumTF:
            if !text.isEmpty {
                phoneNumLabel.text = " "
                if isValidPhoneNumber(phoneNumber: text) == false{
                    phoneNumLabel.text = "Please enter a valid phone number !!"
                }
                
            }else{
                phoneNumLabel.text = "Please enter a phone number"
            }
            
        case emailAddressTF:
            if !text.isEmpty {
                emailAddressLabel.text = " "
                if !(text.contains(".com") && text.contains("@")) {
                    emailAddressLabel.text = "Please enter a valid email address !!"
                }
            }else{
                emailAddressLabel.text = "Please enter an email address"
            }
            
        case passwordTF:
            if !text.isEmpty {
                passwordLabel.text = " "
                if isValidPassword(password: text) == false{
                   passwordLabel.text = "Weak Password!. Minimum of 8 characters with at least 1 uppercase, 1 lowercase, and 1 number"
                    passwordLabel.textColor = .red
                }
            }else{
                passwordLabel.text = "Minimum of 8 characters with at least 1 uppercase, 1 lowercase, and 1 number"
                passwordLabel.textColor = .gray
            }
            
        case dateOfBirthTF:
            if !text.isEmpty {
                if text != dateFormatter.string(from: datePicker!.date) {
                    dateOfBirthTF.text = ""
                    dateOfBirthLabel.text = "Please select your date of birth"
                }
            }else{
                dateOfBirthLabel.text = "Please select your date of birth"
            }
            
        default:
            textField.text = ""
        }

        validationUserInput()
        return true
    }
    

    
    
    func validationUserInput() {
        if (
            firstNameLabel.text    == " " &&
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
    func isValidPassword(password: String) -> Bool {
        let passRegEx = "^(?=.*[a-z\\u0621-\\u064A])(?=.*[A-Z\\u0621-\\u064A])(?=.*[0-9\\u0660-\\u0669])[a-zA-Za-z\\u0621-\\u064A0-9\\u0660-\\u0669]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
           let phoneNumRegEx = "^(?=.*[0-9\\u0660-\\u0669])[0-9\\u0660-\\u0669]{11,11}$"
           let phoneNumTest = NSPredicate(format: "SELF MATCHES %@", phoneNumRegEx)
           return phoneNumTest.evaluate(with: phoneNumber)
       }
    
    func textFieldPlaceholder(textField : UITextField, Placeholder : String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: Placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 90/255, blue: 167/255, alpha: 1.0)]
        )
    }
   
    func ConfigurationDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.maximumDate = NSDate() as Date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)

        dateOfBirthTF.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "MM/dd/yyyy"
        dateOfBirthTF.text = dateFormatter.string(from: datePicker.date)
        dateOfBirthLabel.text = " "
        validationUserInput()
    }
    
    func appeareProfileLabels(firstName:String,lastName:String,email:String,mobile:String,date:String) {
        welcomeUserProfile.text="Your Profile"
        firstNameProfile.isHidden=false
        lastNameProfile.isHidden=false
        mobileNumProfile.isHidden=false
        emailProfile.isHidden=false
        dateProfile.isHidden=false
        passwordStackProfile.isHidden=true
        registerBtnOutlet.setTitle("Save", for: .normal)
        
        
        firstNameTF.text=firstName
        lastNameTF.text=lastName
        mobileNumTF.text=mobile
        emailAddressTF.text=email
        dateOfBirthTF.text=date
        emailAddressTF.isUserInteractionEnabled = false
        emailAddressLabel.text = "Email Address cannot be changed"
        emailAddressLabel.textColor = .darkGray
    }
}

