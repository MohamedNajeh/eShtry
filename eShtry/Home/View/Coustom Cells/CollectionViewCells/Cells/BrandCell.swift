//
//  BrandCell.swift
//  eShtry
//
//  Created by Najeh on 10/03/2022.
//

import UIKit

class BrandCell: UICollectionViewCell {

    @IBOutlet weak var brandImg: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        brandImg.layer.cornerRadius = 25
        contentView.layer.cornerRadius = 25
        contentView.backgroundColor = .white
        // Initialization code
    }
    
    
    func configureCell(cell:BrandCellViewModel){
        self.brandName.text = cell.name
//        self.brandImg.downloadImg(from: "\(cell.imgUrl)")
        self.brandImg.setImage(with: "\(cell.imgUrl)")
    }

}
