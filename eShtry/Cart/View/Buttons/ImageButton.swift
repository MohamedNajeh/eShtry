//
//  ImageButton.swift
//  eShtry
//
//  Created by eslam mohamed on 10/03/2022.
//

import UIKit

class ImageButton: UIButton {

    
    var indexPath = IndexPath(row: 0, section: 0)
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
            
        case .returnBtn:
            let imageIcon = UIImage(named: "arrow-small")?.withTintColor(.white, renderingMode: .alwaysOriginal)

            setImage(imageIcon, for: .normal)

        case .exitBtn:
            let imageIcon = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small))?.withTintColor(.blue, renderingMode: .alwaysOriginal)

            setImage(imageIcon, for: .normal)
        }
    }
    
    
    private func configure(){ translatesAutoresizingMaskIntoConstraints = false }
    
    

}




