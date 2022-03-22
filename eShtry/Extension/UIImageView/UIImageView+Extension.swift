//
//  UIImageView+Extension.swift
//  eShtry
//
//  Created by eslam mohamed on 16/03/2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    
    
//    func downloadImg(from urlString: String){
//        
//        
//        guard let url = URL(string: urlString) else{
//            return}
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if error != nil {return}
//            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{return}
//            guard let data     = data   else{return}
//            guard let image = UIImage(data: data) else{return}
//            DispatchQueue.main.async { self.image = image }
//
//            
//        }
//        task.resume()
//        
//    }
    
    func  setImage(with url : String){
            guard let url = URL(string: url) else { return }
            let placeHolderImage = UIImage(named: "eshtryHolder")
            kf.indicatorType = .activity
            self.kf.setImage(with: url, placeholder: placeHolderImage, options: [.transition(.fade(1))])
        }
    
}
