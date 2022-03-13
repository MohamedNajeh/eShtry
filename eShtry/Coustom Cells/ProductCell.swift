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
        contentView.backgroundColor = UIColor(red: 213/255, green: 179/255, blue: 175/255, alpha: 1)
        productImg.layer.cornerRadius  = 20
        contentView.layer.cornerRadius = 20
    }

}
