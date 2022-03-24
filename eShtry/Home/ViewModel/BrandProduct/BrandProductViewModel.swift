//
//  BrandProductViewModel.swift
//  eShtry
//
//  Created by eslam mohamed on 20/03/2022.
//

import Foundation
import MobileBuySDK

class BrandProductViewModel:NSObject{
    
    
    var products:[Storefront.Product] = []

    var brandProductCellViewModel:[BrandProductCellViewModel] = [BrandProductCellViewModel](){
        didSet{
            self.relodCollectionViewClosure()
        }
    }
    
    var numberOfCells:Int{
        return brandProductCellViewModel.count
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
        
    }
    
    init(vendor:String) {
        super.init()
        fetchProducts(vendor:vendor)
        
    }
    
    func fetchProducts(vendor:String){
        Client.shared.fetchAllCollections { CollectionSort, products in
            if let products = products {
                self.processFetchedBrandProducts(brnadProducts: products[0])
                self.products = products[0]
            }else{
                self.showError = ErrorMessages.invalidData
            }
        }
//        Client.shared.fetchBrandProducts(vendor:vendor) { response in
//            if let products = response {
//                self.processFetchedBrandProducts(brnadProducts: products)
//            }else{
//                self.showError = ErrorMessages.invalidData
//            }
//        }
        
    }
    
    
//    private func createBrandCellViewModel(brandProduct:Storefront.Product)->BrandProductCellViewModel{
//
//
//        return BrandProductCellViewModel(name: brandProduct.title, price: brandProduct., imgUrl: <#T##String#>)
//
//    }
    
    
    
    func getBrandProductCell(at indexPath: IndexPath)->BrandProductCellViewModel{
        return brandProductCellViewModel[indexPath.row]
    }
    
    func createBrandProductCellViewModel(brnadProduct:Storefront.Product)->BrandProductCellViewModel{
        let title = brnadProduct.title
        let price = brnadProduct.priceRange.minVariantPrice.amount
        let image = brnadProduct.images.edges[0].node.url
        let id    = "\(brnadProduct.id)"

        return BrandProductCellViewModel(name: title, price: "\(String(describing: price))", imgUrl: "\(String(describing: image))",id: id)
    }
    
    
    func processFetchedBrandProducts(brnadProducts:[Storefront.Product]){
        
        var cellViewModels = [BrandProductCellViewModel]()
        for brandProduct in brnadProducts {
            cellViewModels.append(createBrandProductCellViewModel(brnadProduct: brandProduct))
        }
        self.brandProductCellViewModel = cellViewModels
    }

    
}

