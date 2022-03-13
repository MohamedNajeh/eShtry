//
//  DefaultImageView.swift
//  eShtry
//
//  Created by eslam mohamed on 10/03/2022.
//

import UIKit

class DefaultImageView: UIImageView {

    let placeHolder = "testImage"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImg()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImg(){
        clipsToBounds      = true
        image              = UIImage(named: placeHolder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    


}
