//
//  UIView+Extension.swift
//  eShtry
//
//  Created by eslam mohamed on 11/03/2022.
//


import UIKit

extension UIView{
    
    func addBorder(color: UIColor){
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}
