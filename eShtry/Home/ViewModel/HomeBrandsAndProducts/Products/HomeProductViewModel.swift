//
//  HomeProductViewModel.swift
//  eShtry
//
//  Created by eslam mohamed on 20/03/2022.
//

import Foundation
import MobileBuySDK

class HomeProductViewModel: NSObject{
    
    
        var homeProductViewModel:[HomeProductCellViewModel] = [HomeProductCellViewModel](){
        didSet{
            self.relodCollectionViewClosure()
        }
    }
    
    var numberOfCells:Int{
        return homeProductViewModel.count
    }
    
    var showError:ErrorMessages!{
        didSet{
            self.showErrorMessage()
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
    
    
    
    var relodCollectionViewClosure: (()->()) = {}
    var showEmptyStateClosure:(()->()) = {}
    var showAlertMessageClosure: (()->()) = {}
    var showErrorMessage: (()->()) = {}
    var bindToShowLoadingToView:  (()->()) = {}
    var bindToHideLoadingToView: (()->())  = {}

    
    
    
    
    
    override init() {
        super.init()
        fetchProductsUsingGrapgQL()
    }
    
    
    
    func fetchProductsUsingGrapgQL(){
        Client.shared.fetchAllProducts { products in
            if let products = products {
                self.processFetchedHomeProducts(homeProducts: products)
            }
            else{
                
            }
        }
    }
    
    
    func getCellViewModel(at indexPath:IndexPath)->HomeProductCellViewModel{
        return homeProductViewModel[indexPath.row]
    }
    
    
    func createHomeProductCellViewModel(homeProduct:Storefront.Product)->HomeProductCellViewModel{
        let imageUrl = "\((homeProduct.featuredImage?.url)!)"
        let title    = homeProduct.title
        let price    = "\(homeProduct.priceRange.minVariantPrice.amount)"
        let id       = "\(homeProduct.id)"
        return HomeProductCellViewModel(name: title, price: price, imgUrl: imageUrl,id:id )
    }
    
    
    func processFetchedHomeProducts(homeProducts:[Storefront.Product]){
        
        var cellVM = [HomeProductCellViewModel]()
        for product in homeProducts{
            cellVM.append(createHomeProductCellViewModel(homeProduct: product))
        }
        
        self.homeProductViewModel = cellVM
        
    }
    
    
    
}
