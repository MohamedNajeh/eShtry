//
//  CartViewModel.swift
//  eShtry
//
//  Created by eslam mohamed on 11/03/2022.
//

import Foundation

class CartViewModel: NSObject{
    
    let networkShared  = NetworkManager.shared
    let coreDataShared = CoreDataManager.shared
    private var cartItems: [CartItem] = [CartItem]()
    
    
     private var cellViewModdels:[CartItemCellViewModel] = [CartItemCellViewModel]() {
        didSet{
            self.relodTableViewClosure()
        }
    }
    
    func getCellViewModelArr()->[CartItemCellViewModel]{
        return self.cellViewModdels
    }
    
    var showEmptyStateView:Bool = true{
        didSet{
            self.showEmptyStateClosure()
        }
    }
    
    var showError:ErrorMessages!{
        didSet{
            self.showErrorMessage()
        }
    }
    
    var numberOfCells:Int{
        return cellViewModdels.count
    }
    
    var totalPrice:Int = 0{
        didSet{
            self.updateCashPriceLabel()
        }
    }
    
    
    var state:State!{
        didSet{
//            self.updateLoadingStatus()
            switch state{
            case .loading:
                self.bindToShowLoadingToView()
            case .finished:
                self.bindToHideLoadingToView()

            default:
                self.bindToShowLoadingToView()
            }
        }
    }
    
    
    var relodTableViewClosure: (()->()) = {}
    var showEmptyStateClosure:(()->()) = {}
    var showAlertMessageClosure: (()->()) = {}
    var showErrorMessage: (()->()) = {}
    var bindToShowLoadingToView:  (()->()) = {}
    var bindToHideLoadingToView: (()->())  = {}
    var updateLoadingStatus: (()->())  = {}
    var updateCashPriceLabel: (()->())  = {}

    
    
    
    override init() {
        super.init()
        self.state = .empty
        fetchCartItems()
    }
    
    
     func fetchCartItems(){
        print("fetchCartItems function ViewModel \n")
         CoreDataManager.shared.updateOrderArr()
        state = .loading
        coreDataShared.getAllWithArray { [weak self] result in
            guard let self = self else{return}
            self.state = .finished
            switch result{
            case .success(let cartItems):
                self.processFetchedCartItems(cartItems: cartItems)
                CoreDataManager.shared.order = cartItems
            case .failure(let error):
                print(error)
                self.showError = error
            }
        }
    }
    
    
    
    func getCellViewModel(at indexPath: IndexPath)->CartItemCellViewModel{
        
        //here i can get any cell by its index
        
        return cellViewModdels[indexPath.row]
    }
    
    
    func createCartItemCellViewModel(cartItem:CartItem)->CartItemCellViewModel{
        
        //here i can manipulte cartItem like making calculations and so on
        let cartItem = CartItemCellViewModel(name: cartItem.name, price: cartItem.price, imgUrl: cartItem.imgUrl,id: cartItem.id,qty: cartItem.qty,variant_id:cartItem.variant_id)
        return cartItem
    }
    
    private func processFetchedCartItems(cartItems: [CartItem]){
        if cartItems.count == 0{
            showEmptyStateView = true
        }
        self.cartItems     = cartItems
        var viewModelCells = [CartItemCellViewModel]()
        for cartItem in cartItems {
            viewModelCells.append(createCartItemCellViewModel(cartItem: cartItem))
        }
        self.cellViewModdels = viewModelCells
        calculateTotalPrice()
    }
    
    
    func calculateTotalPrice(){
        var cartItemPrice = 0
        for item in cellViewModdels{
            guard let price = Int(item.price) else {return}
            guard let qty   = Int(item.qty) else {return}
            cartItemPrice += (price * qty)
        }
        self.totalPrice = cartItemPrice
    }
    
    
    func deleteItem(at indexPath:IndexPath){
        CoreDataManager.shared.deleteCartItem(cartItem: cellViewModdels[indexPath.row])
        self.fetchCartItems()
    }
    
}






//
//
////
////  CartViewModel.swift
////  eShtry
////
////  Created by eslam mohamed on 11/03/2022.
////
//
//import Foundation
//
//class CartViewModel: NSObject{
//    
//    let networkShared  = NetworkManager.shared
//    let coreDataShared = CoreDataManager.shared
//    var arrForOrders   = CoreDataManager.shared.order
//    private var cartItems: [CartItem] = [CartItem]()
//    
//    
//    private var cellViewModdels:[CartItemCellViewModel] = [CartItemCellViewModel]() {
//        didSet{
//            self.relodTableViewClosure()
//        }
//    }
//    
//    
//    var showError:ErrorMessages!{
//        didSet{
//            self.showErrorMessage()
//        }
//    }
//    
//    var numberOfCells:Int{
//        return cellViewModdels.count
//    }
//    
////    var cartItemPrices:Int{
////        return calculateCartItemsPrices()
////    }
//    
//    var state:State!{
//        didSet{
////            self.updateLoadingStatus()
//            switch state{
//            case .loading:
//                self.bindToShowLoadingToView()
//            case .finished:
//                self.bindToHideLoadingToView()
//
//            default:
//                self.bindToShowLoadingToView()
//            }
//        }
//    }
//    
//    
//    var relodTableViewClosure: (()->()) = {}
//    var showEmptyStateClosure:(()->()) = {}
//    var showAlertMessageClosure: (()->()) = {}
//    var showErrorMessage: (()->()) = {}
//    var bindToShowLoadingToView:  (()->()) = {}
//    var bindToHideLoadingToView: (()->())  = {}
//    var updateLoadingStatus: (()->())  = {}
//
//    
//    
//    
//    override init() {
//        super.init()
//        self.state = .empty
//        fetchCartItems()
//    }
//    
//    
//     func fetchCartItems(){
//        print("fetchCartItems function ViewModel \n")
////         CoreDataManager.shared.updateOrderArr()
////        state = .loading
////        coreDataShared.getAllWithArray { [weak self] result in
////            guard let self = self else{return}
////            self.state = .finished
////            switch result{
////            case .success(let cartItems):
////                self.processFetchedCartItems(cartItems: cartItems)
////                CoreDataManager.shared.order = cartItems
////            case .failure(let error):
////                print(error)
////                self.showError = error
////            }
////        }
//         self.processFetchedCartItems(cartItems: arrForOrders)
//
//    }
//    
//    
//    
//    func getCellViewModel(at indexPath: IndexPath)->CartItemCellViewModel{
//        
//        //here i can get any cell by its index
//        
//        return cellViewModdels[indexPath.row]
//    }
//    
//    
//    func createCartItemCellViewModel(cartItem:CartItem)->CartItemCellViewModel{
//        
//        //here i can manipulte cartItem like making calculations and so on
//        
//        
//        return CartItemCellViewModel(name: cartItem.name, price: cartItem.price, imgUrl: cartItem.imgUrl)
//    }
//    
//    private func processFetchedCartItems(cartItems: [CartItem]){
//        self.cartItems     = cartItems
//        var viewModelCells = [CartItemCellViewModel]()
//        for cartItem in cartItems {
//            viewModelCells.append(createCartItemCellViewModel(cartItem: cartItem))
//        }
//        self.cellViewModdels = viewModelCells
//        print("count is \(cellViewModdels.count)")
//    }
//    
//    
////    private func calculateCartItemsPrices()-> Int{
////        var totalPrice = 0
////        for item in cellViewModdels {
////            let itemInt = Int(item.price)
////            print(itemInt)
////            totalPrice += itemInt!
////        }
////        return totalPrice
////    }
//}
