//
//  SeconderyTitleLabel.swift
//  eShtry
//
//  Created by eslam mohamed on 10/03/2022.
//

import UIKit

class SeconderyTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBodyLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

    init(textAlignment: NSTextAlignment, fontSize: CGFloat, fontColor: UIColor) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        self.textColor = fontColor
        self.textAlignment = textAlignment
        configureBodyLabel()
    }
    
    private func configureBodyLabel(){
//        textColor                 = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.90
        lineBreakMode             = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        
    }

}
