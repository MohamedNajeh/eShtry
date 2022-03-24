//
//  CategoryViewModel.swift
//  eShtry
//
//  Created by eslam mohamed on 20/03/2022.
//

import Foundation
import MobileBuySDK

class CategoryViewModel:NSObject{
    
    
    var collections:[Storefront.Collection] = []
    
    var categoryCellViewModel:[CategoryCellViewModel] = [CategoryCellViewModel](){
        didSet{
            self.relodCollectionViewClosure()
        }
    }
    
    var numberOfCells:Int{
        return categoryCellViewModel.count
    }
    
    
    var showMessage:ErrorMessages!{
        didSet{
            self.showErrorMessage()
        }
    }
    
    
    var relodCollectionViewClosure: (()->()) = {}
    var showEmptyStateClosure:(()->()) = {}
    var showAlertMessageClosure: (()->()) = {}
    var showErrorMessage: (()->()) = {}
    var bindToShowLoadingToView:  (()->()) = {}
    var bindToHideLoadingToView: (()->())  = {}
    

    override init(){
        super.init()
        fetchCategories()
    }
    
    
    func fetchCategories(){
        Client.shared.fetchAllCollections { collections, products in
            if let collections = collections {
                self.processFetchedCategory(categories: collections)
            }else{
                self.showMessage = ErrorMessages.invalidDataAfterDecoding
            }
        }
//        Client.shared.fetchAllCollections { collections in
//            if let collections = collections {
//
//                self.processFetchedCategory(categories: collections)
//            }else{
//                self.showMessage = ErrorMessages.invalidDataAfterDecoding
//            }
//        }
    }
    
    
    func getCategoryCellViewModel(at indexPath: IndexPath)->CategoryCellViewModel{
        
        return categoryCellViewModel[indexPath.row]
    }
    
    func createCategoryCellViewModel(category:Storefront.Collection)->CategoryCellViewModel{
        
        
        return CategoryCellViewModel(title: category.title)
    }
    
    func processFetchedCategory(categories:[Storefront.Collection]){
        
        var viewModelCells = [CategoryCellViewModel]()
        for category in categories {
            viewModelCells.append(createCategoryCellViewModel(category: category))
        }
        
        self.categoryCellViewModel = viewModelCells
        
    }
    
    
}
