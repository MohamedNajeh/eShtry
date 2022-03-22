//
//  CartItemCollectionViewCell.swift
//  eShtry
//
//  Created by eslam mohamed on 12/03/2022.
//

import UIKit

class CartItemCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "CartItemCollectionViewCell"
    let cellView       = DefaultView(color: .clear, raduis: 15)
    var imageView      = DefaultImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configureCell(cellVM: CompleteOrderCellViewModel){
        self.imageView.setImage(with: cellVM.imgUrl)
    }
    
    private func configure(){
        
        contentView.addSubview(cellView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "testImage")
        cellView.addSubview(imageView)
        cellView.addBorder(color: UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1))
        
        NSLayoutConstraint.activate([
        
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),

            
            
            
        ])
        
        
        
    }
    
    
}
