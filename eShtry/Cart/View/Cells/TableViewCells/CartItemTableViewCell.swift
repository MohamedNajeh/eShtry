//
//  CartItemTableViewCell.swift
//  eShtry
//
//  Created by eslam mohamed on 10/03/2022.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {

    
    static let reuseID = "CartItemTableViewCell"
    
    let containerView = DefaultView(color: .white, raduis: 15)
    let cellImage     = DefaultImageView(frame: .zero)
    let cellTitle     = SeconderyTitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let cellPrice     = DefaultTitleLabel(textAlignment: .left, fontSize: 18, fontColor: .black)
    let minusBtn      = ImageButton(typeOfBtn: .minusBtn)
    let amountLabel   = SeconderyTitleLabel(textAlignment: .center, fontSize: 10, fontColor: .blue)
    let plusBtn       = ImageButton(typeOfBtn: .plusBtn)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        configureContainerView()
        configureCellImage()
        configureCellTitle()
        configureCellPrice()
        configureMinusBtn()
        configurePlusBtn()
        configureAmountLabel()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func configureContainerView(){
        self.backgroundColor = .white
        contentView.addSubview(containerView)
        containerView.addBorder(color: UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1))
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    private func configureCellImage(){
        containerView.addSubview(cellImage)
//        cellImage.backgroundColor = .yellow
        cellImage.layer.cornerRadius = 10
        cellImage.addBorder(color: UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1))
//        cellImage.contentMode = .center
        cellImage.contentMode = .scaleAspectFill
        cellImage.clipsToBounds = true
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
//            cellImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            cellImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            cellImage.widthAnchor.constraint(equalToConstant: 60),
            cellImage.heightAnchor.constraint(equalToConstant: 80)

        ])
    }
    
    
    private func configureCellTitle(){
        containerView.addSubview(cellTitle)
        cellTitle.numberOfLines = 3
        cellTitle.text = "AddBorder(color: UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1))"
        NSLayoutConstraint.activate([
            cellTitle.topAnchor.constraint(equalTo: cellImage.topAnchor),
            cellTitle.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10),
            cellTitle.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 30)
        ])
    }
    
    
    private func configureCellPrice(){
        containerView.addSubview(cellPrice)
        cellPrice.text = "EGP 999.999"
        NSLayoutConstraint.activate([
            cellPrice.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 5),
            cellPrice.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10),
            cellPrice.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 30),
            cellPrice.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }

    private func configureMinusBtn(){
        containerView.addSubview(minusBtn)
        minusBtn.backgroundColor = UIColor(red: 255/255, green: 195/255, blue: 199/255, alpha: 1)
        minusBtn.layer.cornerRadius = 5

        NSLayoutConstraint.activate([
            minusBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            minusBtn.widthAnchor.constraint(equalToConstant: 30),
            minusBtn.heightAnchor.constraint(equalToConstant: 30),
            minusBtn.leadingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 50)
        ])
    }

    
    private func configurePlusBtn(){
        containerView.addSubview(plusBtn)
        plusBtn.backgroundColor = UIColor(red: 240/255, green: 0, blue: 0, alpha: 1)
        plusBtn.layer.cornerRadius = 5

        NSLayoutConstraint.activate([
            plusBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            plusBtn.widthAnchor.constraint(equalToConstant: 30),
            plusBtn.heightAnchor.constraint(equalToConstant: 30),
            plusBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

        ])
    }

    
    private func configureAmountLabel(){
        containerView.addSubview(amountLabel)
        amountLabel.text = "1"

        amountLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: minusBtn.topAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: minusBtn.trailingAnchor, constant: 5),
            amountLabel.trailingAnchor.constraint(equalTo: plusBtn.leadingAnchor, constant: -5),
            amountLabel.bottomAnchor.constraint(equalTo: minusBtn.bottomAnchor)
        ])
    }
    
}
