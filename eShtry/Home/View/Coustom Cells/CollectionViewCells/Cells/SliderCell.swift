//
//  SliderCell.swift
//  eShtry
//
//  Created by Najeh on 10/03/2022.
//

import UIKit

class SliderCell: UICollectionViewCell {

    @IBOutlet weak var sliderImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        sliderImg.layer.cornerRadius = 8
        sliderImg.contentMode = .scaleAspectFill
        // Initialization code
    }

}
