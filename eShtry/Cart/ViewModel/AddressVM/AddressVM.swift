//
//  AddressViewModel.swift
//  eShtry
//
//  Created by eslam mohamed on 21/03/2022.
//

import Foundation

class AddressViewModel:NSObject{
    
    
    var userId = 0
    let userDefaults = UserDefaults.standard
    let networkShared = NetworkManager.shared
    
    var cellViewModels:[AddressCellViewModel] = [AddressCellViewModel](){
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
        return cellViewModels.count
    }
    
    
    var relodCollectionViewClosure: (()->()) = {}
    var showEmptyStateClosure:(()->()) = {}
    var showAlertMessageClosure: (()->()) = {}
    var showErrorMessage: (()->()) = {}
    var bindToShowLoadingToView:  (()->()) = {}
    var bindToHideLoadingToView: (()->())  = {}
    var updateLoadingStatus: (()->())  = {}
    
    
    
    override init() {
        super.init()
        fetchDataFromApi()
    }
    
    
    func fetchDataFromApi(){
        userId = userDefaults.object(forKey: "userId") as? Int ?? 0
        networkShared.getDataFromApi(urlString: allAddresses(userId: userId), baseModel: AddressesRoot.self) { (result) in
            switch result {
            case .success(let data):
                if let allAdds = data.addresses {
                    self.processFetchedAddress(address: allAdds)
                }
            case .failure(let error):
                print(error)
                self.showError = error
            }
        }
    }
    
    
    func getCellViewModel(at indexPath: IndexPath)->AddressCellViewModel{
        
        return cellViewModels[indexPath.row]
    }
    
    
    func createAddressCellViewModel(address:Addresses)->AddressCellViewModel{
        
        let title = address.address2
        let owner = address.name
        let phone = address.phone
        let cityCountry = "\(address.city!) , \(address.country!)"
        let address = address.address1
        
        return AddressCellViewModel(addressTitle: title!, owner: owner!, phoneNumber: phone!, cityCountry: cityCountry, address: address!)
    }
    
    
    func processFetchedAddress(address:[Addresses]){
        var cellViewModels = [AddressCellViewModel]()
        for address in address {
            cellViewModels.append(createAddressCellViewModel(address: address))
        }
        self.cellViewModels = cellViewModels
    }
    
    
    
    
}

