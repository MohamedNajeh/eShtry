//
//  LineView.swift
//  eShtry
//
//  Created by eslam mohamed on 12/03/2022.
//

import UIKit

class LineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        self.frame.size.height = 1
        backgroundColor        = .lightGray
    }
}
