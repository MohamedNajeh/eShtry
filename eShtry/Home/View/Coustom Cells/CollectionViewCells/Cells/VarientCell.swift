//
//  VarientCell.swift
//  eShtry
//
//  Created by Najeh on 21/03/2022.
//

import UIKit

class VarientCell: UICollectionViewCell {

    @IBOutlet weak var varientTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = UIColor(red: 43/255, green: 95/255, blue: 147/255, alpha: 1)
        // Initialization code
    }

}
