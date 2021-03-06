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
    var addToFavorites: (()->())?
    
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor(red: 43/255, green: 95/255, blue: 147/255, alpha: 0.75)
        

        productImg.layer.cornerRadius  = 10
        contentView.layer.cornerRadius = 10
    }
    
    func configure(cellVM:BrandProductCellViewModel){
        self.productName.text = cellVM.name
        self.productPrice.text = cellVM.price
//        self.productImg.downloadImg(from: cellVM.imgUrl)
        self.productImg.setImage(with: cellVM.imgUrl)
    }
    
    
    func configureHomeProduct(cellVM:HomeProductCellViewModel){
        self.productName.text = cellVM.name
        self.productPrice.text = cellVM.price
//        self.productImg.downloadImg(from: cellVM.imgUrl)
        self.productImg.setImage(with: cellVM.imgUrl)
    }
    
    
    
    func downloadImg(from urlString: String){
        
//        productImg.downloadImg(from: urlString).
        productImg.setImage(with: urlString)

    }

    @IBAction func addToFavoriteButtonClicked(_ sender: Any) {
        self.addToFavorites?()
    }
    
}
