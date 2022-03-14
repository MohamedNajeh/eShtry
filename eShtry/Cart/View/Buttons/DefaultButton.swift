//
//  DefaultButton.swift
//  eShtry
//
//  Created by eslam mohamed on 10/03/2022.
//

import UIKit

class DefaultButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    init(btnTitle: String, titleColor: UIColor, backgroundColor: UIColor, raduis: CGFloat ) {
        super.init(frame: .zero)
        configure()
        setTitle(btnTitle, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont(name: "Almarai-ExtraBold", size: 20)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = raduis
    }
    
    
    private func configure(){ translatesAutoresizingMaskIntoConstraints = false }
}
