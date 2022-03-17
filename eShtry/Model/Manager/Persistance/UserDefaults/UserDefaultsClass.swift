//
//  UserDefaults.swift
//  eShtry
//
//  Created by eslam mohamed on 17/03/2022.
//

import Foundation

class UserDefaultsClass{
    
    static let shared = UserDefaultsClass()
    
    
    static func saveUserID(value: Any, key:String){
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    func saveValue<V>(value:V,key: String){
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    func getValue
}
