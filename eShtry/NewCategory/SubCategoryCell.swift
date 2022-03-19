//
//  SubCategoryCell.swift
//  Caregory
//
//  Created by Mahmoud Ghoneim on 3/12/22.
//

import UIKit
import MobileBuySDK
class SubCategoryCell:UITableViewCell {
    
    
    static let reuseID = "SubCategoryCell"
    var products:[Storefront.Product] = [] {
        didSet{
            self.productCollectionView.reloadData()
        }
    }
    @IBOutlet weak var subCategorynameLabel: UILabel!
    @IBOutlet weak var expandedImageView: UIImageView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var bottomView: UIView!{
        didSet{
            bottomView.isHidden = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productCollectionView.delegate   = self
        productCollectionView.dataSource = self
        selectionStyle = .none
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.layer.shadowRadius  = 4.0
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowColor   = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension SubCategoryCell: UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.reuseID, for: indexPath) as! ProductCollectionCell
        cell.configureCell(image: products[indexPath.row].featuredImage!.url, title: products[indexPath.row].title)
        return cell
    }
    
    
}


extension SubCategoryCell:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 , height: collectionView.frame.height)
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}
