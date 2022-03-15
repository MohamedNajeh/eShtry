//
//  CategoryCell.swift
//  eShtry
//
//  Created by Mahmoud Ghoneim on 3/11/22.
//

import UIKit

class CategoryCell: UITableViewCell {

    static let reuseID = String(describing: CategoryCell.self)
    
    @IBOutlet weak var categorylabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = .black
        selectedView.layer.cornerRadius = 10
        selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            categorylabel.textColor = .white
            categorylabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        }else{
            categorylabel.textColor = .black
            categorylabel.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        }
        
        
        
    }
    
    
   
    

}
