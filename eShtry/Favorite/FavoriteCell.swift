//
//  FavoriteCell.swift
//  eShtry
//
//  Created by Mahmoud Ghoneim on 3/16/22.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID = String(describing: FavoriteCell.self)
    
    @IBOutlet weak var productImageView: UIImageView!{
        didSet{
            productImageView.layer.cornerRadius = productImageView.frame.size.width / 2
        }
    }
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productCreationDateLabel: UILabel!
    
    var removeFromFavorites: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.layer.shadowRadius  = 4.0
        contentView.layer.shadowOpacity = 0.6
        contentView.layer.shadowColor   = UIColor.lightGray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func removeProductFromFavorites(_ sender: Any) {
        self.removeFromFavorites?()
    }
    
}
