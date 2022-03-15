//
//  SubCategoryCell.swift
//  Caregory
//
//  Created by Mahmoud Ghoneim on 3/12/22.
//

import UIKit

class SubCategoryCell:UITableViewCell {
    
    
    static let reuseID = "SubCategoryCell"
    
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension SubCategoryCell: UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.reuseID, for: indexPath) as! ProductCollectionCell
        cell.configureCell()
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
