//
//  UIImageView+Extension.swift
//  eShtry
//
//  Created by eslam mohamed on 16/03/2022.
//

import Foundation
import UIKit

extension UIImageView{
    
    
    func downloadImg(from urlString: String){
        
        
        guard let url = URL(string: urlString) else{
            return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {return}
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{return}
            guard let data     = data   else{return}
            guard let image = UIImage(data: data) else{return}
            DispatchQueue.main.async { self.image = image }

            
        }
        task.resume()
        
    }
    
}
