//
//  CompleteOrderViewModel.swift
//  eShtry
//
//  Created by eslam mohamed on 22/03/2022.
//

import Foundation

class CompleteOrderViewModel:NSObject{
    
    
    let coreDataShared = CoreDataManager.shared

    
    private var titleForAddress = ""{
        didSet{
            self.updateTitleAddressClosure()
        }
    }
    
    func getTitle()->String{
        return titleForAddress
    }
    
    
    private var shipmentAddress = ""{
        didSet{
            self.updateShipmentAddressClosure()
        }
    }
    
    func getShipmentAddress()->String{
        return shipmentAddress
    }
    
    private var shipmentNumber = ""{
        didSet{
            self.updateShipmentNumberClosure()
        }
    }
    
    private var deliverDate = "" {
        didSet{
            self.updateDeliverDateClosure()
        }
    }
    
    
    var itemsCellViewModels:[CompleteOrderCellViewModel] = [CompleteOrderCellViewModel](){
        didSet{
            self.reloadCollectionViewClosure()
        }
    }
    
    var numberOfCells:Int!{
        return itemsCellViewModels.count
    }
    
    var totalPrice:Int = 0{
        didSet{
            self.updateCashPriceLabel()
        }
    }
    
    var updateTitleAddressClosure:(()->())    = {}
    var updateShipmentAddressClosure:(()->()) = {}
    var updateShipmentNumberClosure:(()->())  = {}
    var updateDeliverDateClosure:(()->())     = {}
    var reloadCollectionViewClosure:(()->())  = {}
    var updateCashPriceLabel:(()->()) = {}
    
    
    override init() {
        super.init()
        fetchData()
    }
    
    
    func fetchData(){
        
        fetchAddressDataFromCoreData()
        fetchAllCartItemData()
        
    }
    
    private func fetchAddressDataFromCoreData(){
        coreDataShared.getAllAddressWithArray { [weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let address):
                self.processFetchedAddress(addresses: address)
            case .failure(let error):
                print(error)
                
            }
        }

    }
    
    private func fetchAllCartItemData(){
        coreDataShared.getAllWithArray { [weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let cartItems):
                self.processFetchedCartItems(cartItems: cartItems)
                CoreDataManager.shared.order = cartItems
            case .failure(let error):
                print(error)
            }
        }
        calculateTotalPrice()

    }
    
    func calculateTotalPrice(){
        var cartItemPrice = 0
        for item in itemsCellViewModels{
            guard let price = Int(item.price) else {return}
            guard let qty   = Int(item.qty) else {return}
            cartItemPrice += (price * qty)
        }
        self.totalPrice = cartItemPrice
    }

    
    func processFetchedAddress(addresses:[AddressCellViewModel]){
        var addressTitle    = ""
        var shipmentAddress = ""
        for address in addresses {
            print(address.isDefault)
            if address.isDefault == "isDefault"{
                addressTitle    = address.addressTitle
                shipmentAddress = address.address
            }
        }
        
        self.titleForAddress = addressTitle
        self.shipmentAddress = shipmentAddress
    }
    
    

    
    private func processFetchedCartItems(cartItems: [CartItem]){
        var viewModelCells = [CompleteOrderCellViewModel]()
        for cartItem in cartItems {
            viewModelCells.append(createCartItemCellViewModel(cartItem: cartItem))
        }
        self.itemsCellViewModels = viewModelCells
    }
    
    
    func createCartItemCellViewModel(cartItem:CartItem)->CompleteOrderCellViewModel{
        
        //here i can manipulte cartItem like making calculations and so on
        let orderItem = CompleteOrderCellViewModel(name: cartItem.name, price: cartItem.price, imgUrl: cartItem.imgUrl,id: cartItem.id,qty: cartItem.qty,variant_id:cartItem.variant_id)
        return orderItem
    }
    
    
    func getCellViewModel(at indexPath: IndexPath)->CompleteOrderCellViewModel{
        
        //here i can get any cell by its index
        
        return itemsCellViewModels[indexPath.row]
    }

    
    
    
}
