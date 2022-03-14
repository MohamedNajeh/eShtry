//
//  ProductCollectionCell.swift
//  Caregory
//
//  Created by Mahmoud Ghoneim on 3/12/22.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {
    
    
    static let reuseID = "ProductCollectionCell"
    
    @IBOutlet weak var productImageView: UIImageView!{
        didSet{
            productImageView.layer.cornerRadius = productImageView.frame.height / 2
        }
    }
    @IBOutlet weak var productLabel: UILabel!
    
    
    func configureCell(){
        productImageView.image = UIImage(named: "product")
        productLabel.text = "Product"
    }
}
