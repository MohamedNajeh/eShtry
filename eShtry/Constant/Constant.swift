//
//  Constant.swift
//  eShtry
//
//  Created by eslam mohamed on 10/03/2022.
//

import Foundation
import UIKit

let productsUrl = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/products.json"

let singleProductUrl = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/products/6905518063663.json"

let customers = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/customers.json"

let customerInfo = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/customers/5748952236079.json"

let customCollections = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/custom_collections.json"

let productsForCustomCollection = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/products.json?collection_id=272068870191"


let orders = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/orders.json"


let orderInfo = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/orders/4412317073455.json"


let countries = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/countries.json"

let currencies = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/currencies.json"


func addressById(userId : Int,addressId : Int)->String{
    let url = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/customers/\(userId)/addresses/\(addressId).json"
    return url
}


func allAddresses (userId : Int)->String{
    let url = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/customers/\(userId)/addresses.json"
    return url
}

func customerById (userId : Int)->String{
    let url = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/customers/\(userId).json"
    return url
}


enum typeOfButton{
    case plusBtn
    case minusBtn
    case returnBtn
    case exitBtn
}

enum qtyTypeProcess{
    case addition
    case subtraction
}


enum httpMethod:String{
    case post = "POST"
    case get  = "GET"
}

func isValidZipCode(zipCode: String) -> Bool {
    let zipCodeRegEx = "^(?=.*[0-9+\\u0660-\\u0669])[0-9+\\u0660-\\u0669]{4,6}$"
    let zipCodeTest = NSPredicate(format: "SELF MATCHES %@", zipCodeRegEx)
    return zipCodeTest.evaluate(with: zipCode)
}


func isValidPhoneNumber(phoneNumber: String) -> Bool {
    let phoneNumRegEx = "^(?=.*[0-9\\u0660-\\u0669])[0-9\\u0660-\\u0669]{11,11}$"
    let phoneNumTest = NSPredicate(format: "SELF MATCHES %@", phoneNumRegEx)
    return phoneNumTest.evaluate(with: phoneNumber)
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

func textFieldPlaceholder(textField : UITextField, Placeholder : String) {
    textField.attributedPlaceholder = NSAttributedString(
        string: Placeholder,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 90/255, blue: 167/255, alpha: 0.55)]
    )
}


enum State{
    case loading
    case error
    case empty
    case finished
}
