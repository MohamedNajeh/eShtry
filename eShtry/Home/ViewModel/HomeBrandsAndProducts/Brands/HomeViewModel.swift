//
//  HomeViewModel.swift
//  eShtry
//
//  Created by eslam mohamed on 19/03/2022.
//

import Foundation
import MobileBuySDK
class HomeViewModel:NSObject{
    
    let networkShared  = NetworkManager.shared
    var brandItems: [Storefront.Collection] = [Storefront.Collection]()
    var allProducts:[[Storefront.Product]] = []



    private var cellViewModdels:[BrandCellViewModel] = [BrandCellViewModel]() {
        didSet{
            self.relodCollectionViewClosure()
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
        self.state = .empty
        fetchData()
    }
    
    func fetchData(){
        state = .loading
        Client.shared.fetchAllCollections { collections , products in
            self.state = .finished
            if let collections = collections {
                self.processFetchedBrandItems(brandItems: collections)
                self.brandItems = collections
                guard let products = products else{
                    return
                }
                self.allProducts = products
                print(products)
            }
            else{
                self.showError = .invalidData
            }
        }
    }
    
//    func fetchData(){
//        state = .loading
//        networkShared.getDataFromApi(urlString: "https://f36da23eb91a2fd4cba11b9a30ff124f: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@jets-ismailia.myshopify.com/admin/api/2022-01/smart_collections.json", baseModel: SmartCollectionRoot.self) { result  in
//            self.state = .finished
//            switch result{
//            case .success(let result):
//                guard let smartCollection = result.smart_collections else {return}
//                self.processFetchedBrandItems(brandItems: smartCollection)
//                self.brandItems = smartCollection
//            case .failure(let error):
//                print(error)
//                self.showError = error
//            }
//        }
//
//    }
    
    func getCellViewModel(at indexPath: IndexPath)->BrandCellViewModel{
        
        //here i can get any cell by its index
        
        return cellViewModdels[indexPath.row]
    }
    
    func createCartItemCellViewModel(brandItem:Storefront.Collection)->BrandCellViewModel{
        
        //here i can manipulte cartItem like making calculations and so on
        
        return BrandCellViewModel(name: brandItem.title, imgUrl: "\(brandItem.image!.url)")
    }
    
    private func processFetchedBrandItems(brandItems: [Storefront.Collection]){
//        self.brandItems     = brandItems
        var viewModelCells = [BrandCellViewModel]()
        for brand in brandItems {
            viewModelCells.append(createCartItemCellViewModel(brandItem: brand))
        }
        self.cellViewModdels = viewModelCells
    }

    
    
}
