//
//  ImageButton.swift
//  eShtry
//
//  Created by eslam mohamed on 10/03/2022.
//

import UIKit

class ImageButton: UIButton {

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(typeOfBtn: typeOfButton){
        super.init(frame: .zero)
        configure()
        switch typeOfBtn {
        case .plusBtn:
            let imageIcon = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small))?.withTintColor(.white, renderingMode: .alwaysOriginal)
            setImage(imageIcon, for: .normal)
        case .minusBtn:
            let imageIcon = UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small))?.withTintColor(.red, renderingMode: .alwaysOriginal)

            setImage(imageIcon, for: .normal)

            
        }
    }
    
    
    private func configure(){ translatesAutoresizingMaskIntoConstraints = false }
    
    

}




