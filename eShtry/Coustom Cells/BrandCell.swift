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
        brandImg.layer.cornerRadius = brandImg.frame.width/2
        // Initialization code
    }

}
