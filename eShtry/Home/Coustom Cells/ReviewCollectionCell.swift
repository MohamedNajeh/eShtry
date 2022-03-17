//
//  ReviewCollectionCell.swift
//  eShtry
//
//  Created by Najeh on 12/03/2022.
//

import UIKit

class ReviewCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        // Initialization code
    }

}
