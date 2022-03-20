//
//  SearchingCell.swift
//  eShtry
//
//  Created by Mahmoud Ghoneim on 3/15/22.
//

import UIKit

class SearchingCell: UITableViewCell {
    
    static let reuseID = "SearchingCell"
    // print
    @IBOutlet weak var productImageView: UIImageView!{
        didSet{
            productImageView.layer.cornerRadius = productImageView.frame.height / 2
        }
    }
    @IBOutlet weak var productnamelabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.layer.shadowRadius  = 4.0
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowColor   = UIColor.lightGray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
        func configureCell(product:Products){
            productImageView.downloadImg(from: (product.image?.src)!)
            productnamelabel.text = product.title
        }
    
    
        
        func configureCell(category:SmartCollection){
            productImageView.downloadImg(from: (category.image?.src)!)
            productnamelabel.text = category.title
        }
    

}
