//
//  TopRoundView.swift
//  eShtry
//
//  Created by eslam mohamed on 11/03/2022.
//

import UIKit

class TopRoundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configure()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    init(raduis:CGFloat, color: UIColor ) {
        super.init(frame: .zero)
        layer.cornerRadius   = raduis
        self.backgroundColor = color
        configure()
    }
    
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.maskedCorners = [ .layerMaxXMinYCorner,.layerMinXMinYCorner]
    }
    

}
