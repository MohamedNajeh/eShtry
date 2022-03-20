//
//  OffersCell.swift
//  eShtry
//
//  Created by Najeh on 10/03/2022.
//

import UIKit

class OffersCell: UICollectionViewCell {

    @IBOutlet weak var offerImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        offerImg.layer.cornerRadius = 10
        // Initialization code
    }

}
