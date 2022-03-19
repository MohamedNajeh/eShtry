//
//  ProductCell.swift
//  eShtry
//
//  Created by Najeh on 10/03/2022.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor(red: 14/255, green: 90/255, blue: 167/255, alpha: 0.25)
        

        productImg.layer.cornerRadius  = 10
        contentView.layer.cornerRadius = 10
    }
    
    
    
    
    func downloadImg(from urlString: String){
        
        productImg.downloadImg(from: urlString)
        
        

    }

}
