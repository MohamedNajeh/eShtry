//
//  UIViewController+Extension.swift
//  eShtry
//
//  Created by eslam mohamed on 17/03/2022.
//


import UIKit

extension UIViewController{
    
    
    static func showToast(controller: UIViewController, message: String, seconds: Double){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 0.8)
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "Almarai-Bold", size: 20)!,NSAttributedString.Key.foregroundColor: UIColor(red: 0.0/255.0, green: 129.0/255.0, blue: 138.0/255.0, alpha: 1.0)]
        let titleString = NSAttributedString(string: message, attributes: titleAttributes)
        
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    
    static func presentAlert(controller: UIViewController,title:String, message: String,style:UIAlertController.Style,actionTitle:String,action:@escaping (_ action:UIAlertAction)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle:style )
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: action))
         controller.present(alert, animated: true, completion: nil)
        
        
    }
}
