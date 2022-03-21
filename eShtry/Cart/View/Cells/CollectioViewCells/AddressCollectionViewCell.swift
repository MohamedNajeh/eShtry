//
//  AddressCollectionViewCell.swift
//  eShtry
//
//  Created by eslam mohamed on 18/03/2022.
//

import UIKit

class AddressCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "AddressCollectionViewCell"
    let cellView       = DefaultView(color: .clear, raduis: 15)
    let selectionImage = DefaultImageView(frame: .zero)
    let addressTitle   = SeconderyTitleLabel(textAlignment: .left, fontSize: 20, fontColor: UIColor(red: 37/255, green: 67/255, blue: 150/255, alpha: 1))
    let owner   = SeconderyTitleLabel(textAlignment: .left, fontSize: 18, fontColor: UIColor(red: 37/255, green: 67/255, blue: 150/255, alpha: 1))
    let phoneNumber   = SeconderyTitleLabel(textAlignment: .left, fontSize: 17, fontColor: UIColor(red: 37/255, green: 67/255, blue: 150/255, alpha: 1))
    let address   = SeconderyTitleLabel(textAlignment: .left, fontSize: 16, fontColor: UIColor(red: 37/255, green: 67/255, blue: 150/255, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureSelectionImage()
        configureAddressTitle()
        configureOwner()
        configurePhoneNumber()
        configureAddress()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectionImage.image = UIImage(systemName: "circle.fill")
            }else{
                selectionImage.image = UIImage(systemName: "circle")

            }
        }
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(cellVM: AddressCellViewModel){
        self.addressTitle.text = cellVM.addressTitle
        self.owner.text        = cellVM.owner
        self.phoneNumber.text  = cellVM.phoneNumber
        self.address.text      = "\(cellVM.cityCountry) \n \(cellVM.address) "
        
    }
    
    private func configure(){
        contentView.addSubview(cellView)
        cellView.backgroundColor = UIColor(red: 232/255, green: 235/255, blue: 245/255, alpha: 1)
        cellView.addBorder(color: UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1))
        
        NSLayoutConstraint.activate([
        
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func configureSelectionImage(){
        cellView.addSubview(selectionImage)
        selectionImage.image = UIImage(systemName: "circle")
        NSLayoutConstraint.activate([
            selectionImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            selectionImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10)
        ])
    }
    
    private func configureAddressTitle(){
        cellView.addSubview(addressTitle)
        addressTitle.text = ""
        NSLayoutConstraint.activate([
            addressTitle.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 15),
            addressTitle.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            addressTitle.trailingAnchor.constraint(equalTo: cellView.centerXAnchor, constant: -20),
            addressTitle.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureOwner(){
        cellView.addSubview(owner)
        owner.text = ""
        NSLayoutConstraint.activate([
            owner.topAnchor.constraint(equalTo: addressTitle.bottomAnchor, constant: 10),
            owner.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            owner.trailingAnchor.constraint(equalTo: cellView.centerXAnchor, constant: -20),
            owner.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configurePhoneNumber(){
        cellView.addSubview(phoneNumber)
        phoneNumber.text = ""
        NSLayoutConstraint.activate([
            phoneNumber.topAnchor.constraint(equalTo: owner.bottomAnchor, constant: 10),
            phoneNumber.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            phoneNumber.trailingAnchor.constraint(equalTo: cellView.centerXAnchor, constant: -20),
            phoneNumber.heightAnchor.constraint(equalToConstant: 19)
        ])
    }
    
    private func configureAddress(){
        cellView.addSubview(address)
        address.text = ""
        address.numberOfLines = 3
        NSLayoutConstraint.activate([
            address.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor),
            address.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            address.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            address.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -5),
        ])
    }

    
}
