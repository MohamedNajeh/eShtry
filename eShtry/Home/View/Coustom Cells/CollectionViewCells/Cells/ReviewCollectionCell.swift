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
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.backgroundColor = UIColor(red: 43/255, green: 95/255, blue: 147/255, alpha: 0.75)
    }

}
