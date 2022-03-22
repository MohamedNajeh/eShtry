//
//  CoreDataManager.swift
//  eShtry
//
//  Created by eslam mohamed on 17/03/2022.
//

import Foundation
import CoreData

class CoreDataManager{
    
    
    static let shared = CoreDataManager()
    static let orderUpdatedNotification = Notification.Name("orderUpdated")
    
    
    var order = [CartItem]() {
        didSet {
            NotificationCenter.default.post(name:CoreDataManager.orderUpdatedNotification,object:nil)
        }
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EshtryCoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func isInFovorite(productId: String)-> Bool{
        var results:[NSManagedObject] = []
        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteProduct")
            fetchRequest.predicate = NSPredicate(format: "id == %@", productId)
            let context = persistentContainer.viewContext
            
            results = try context.fetch(fetchRequest)
            print(results.first)
        } catch let error {
            print("unable to complete  :", error)
        }
        return results.count > 0
    }
    
    
    
    func deleteProduct(product: Product){
       
            do {
                let context = self.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteProduct")
                
                fetchRequest.predicate = NSPredicate(format: "id == %@", product.id ?? "1"  )
                let result = try context.fetch(fetchRequest)
                context.delete((result as! [NSManagedObject]).first!)
                try context.save()
                print("product deleted successfully")
            } catch let error {
                print("error while deleting product :", error)
            }
        
    }
    
    
    func insert(product: Product){
        let managedObjectContext = persistentContainer.viewContext
        let entity          = NSEntityDescription.entity(forEntityName: "FavoriteProduct", in: managedObjectContext)!
        let favoriteProduct = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        
        favoriteProduct.setValue("\(product.id)", forKey: "id")
        favoriteProduct.setValue(product.name, forKey: "name")
        favoriteProduct.setValue(product.imageUrl, forKey: "imageUrl")
        do{
            try managedObjectContext.save()
            print("new product saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    func getAllFavoriteProducts() -> [Product]
    {
        let context = self.persistentContainer.viewContext
        var objects:[NSManagedObject] = []
        var products:[Product] = []
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "FavoriteProduct")
        do{
            objects = try context.fetch(fetchReq)
            for product in objects{
                let p = Product(id: product.value(forKey: "id") as! String, imageUrl: product.value(forKey: "imageUrl") as! String , name: product.value(forKey: "name") as! String)
                products.append(p)
            }
        }catch let error as NSError{
            print(error)
        }
        return products
    }
    
    
    
    func insertCartItem(cartItem: CartItem,qtyTypeProcess:qtyTypeProcess){
        
        if checkCartItemBeforeInsert(cartItem: cartItem,qtyTypeProcess:qtyTypeProcess){
            print("object already saved")
        }else{
            let managedObjectContext = persistentContainer.viewContext
            let entity           = NSEntityDescription.entity(forEntityName: "Cart", in: managedObjectContext)!
            let cartItemCoreData = NSManagedObject(entity: entity, insertInto: managedObjectContext)
            
            cartItemCoreData.setValue(cartItem.name, forKey: "name")
            cartItemCoreData.setValue(cartItem.imgUrl, forKey: "imgUrl")
            cartItemCoreData.setValue(cartItem.price, forKey: "price")
            cartItemCoreData.setValue(cartItem.id, forKey: "id")
            cartItemCoreData.setValue(cartItem.qty, forKey: "quantity")
            cartItemCoreData.setValue(cartItem.variant_id, forKey: "variantId")

            
            
            do{
                try managedObjectContext.save()
                print("new product saved")
                updateOrderArr()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        

        
    }
    
    
    func checkCartItemBeforeInsert(cartItem: CartItem,qtyTypeProcess:qtyTypeProcess)->Bool{
        var success = false
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")
        fetchRequest.predicate = NSPredicate(format: "id == %@", cartItem.id)
        do{
           let objects = try managedObjectContext.fetch(fetchRequest)
            if objects.count == 1 {
                let cartItemUpdate = objects[0]
                let oldQytStr = cartItemUpdate.value(forKey: "quantity") as! String
                let oldQytInt = Int(oldQytStr)!
                let qty       = 1
                switch qtyTypeProcess{
                case .addition:
                    cartItemUpdate.setValue("\(oldQytInt + qty)", forKey: "quantity")
                case .subtraction:
                    cartItemUpdate.setValue("\(oldQytInt - qty)", forKey: "quantity")
                    
                }
                self.saveContext()
                success = true
            }

        }catch let error as NSError {
            print("Could not retrive data . \(error), \(error.userInfo)")
            success = false
        }
        return success
    }
    
    
    
    func saveOrderArrToCoreData(cartItemArr: [CartItem]){
        for cartItem in cartItemArr{
            insertCartItem(cartItem: cartItem,qtyTypeProcess: .addition)
        }
        
    }
    
    
    func updateOrderArr(){
        self.order = [CartItem]()
        getAllWithArray { result in
            switch result{
            case .success(let cartItem):
                CoreDataManager.shared.order = cartItem
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func getAllOfNSManageObjectArr(completion:@escaping((Result<[NSManagedObject],ErrorMessages>)->Void)){
        var objects = [NSManagedObject]()
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")
        do{
            objects = try managedObjectContext.fetch(fetchRequest)
            completion(.success(objects))
        }catch let error as NSError {
            print("Could not retrive data . \(error), \(error.userInfo)")
            completion(.failure(.errorRetivingFromCoreData))
        }
    }
    
    func getAllWithArray( completion: @escaping ((Result<[CartItem], ErrorMessages>)->Void)){
        var arrOfCartItem = [CartItem]()
        
        getAllOfNSManageObjectArr { result in
            switch result{
            case .success(let arr):
                for item in arr{
                    let cartItem = CartItem(name: item.value(forKey: "name") as! String, price: item.value(forKey: "price") as! String, imgUrl: item.value(forKey: "imgUrl") as! String,id: item.value(forKey: "id") as! String,qty: item.value(forKey: "quantity") as! String,variant_id: item.value(forKey: "variantId") as! String )
                    arrOfCartItem.append(cartItem)
                }
                completion(.success(arrOfCartItem))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
        
        
        
        //
        //        for item in getAllOfNSManageObjectArr(){
        //            let cartItem = CartItem(name: item.value(forKey: "name") as! String, price: item.value(forKey: "price") as! String, imgUrl: item.value(forKey: "imgUrl") as! String )
        //            arrOfCartItem.append(cartItem)
        //        }
        //        completion(arrOfCartItem)
    }
    
    func deleteCartItem(cartItem: CartItemCellViewModel){
       
            do {
                let context = self.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
                
                fetchRequest.predicate = NSPredicate(format: "id == %@", cartItem.id  )
                let result = try context.fetch(fetchRequest)
                context.delete((result as! [NSManagedObject]).first!)
                try context.save()
                print("product deleted successfully")
            } catch let error {
                print("error while deleting product :", error)
            }
        
    }
    
    func deleteAll(){
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest         = NSFetchRequest<NSManagedObject>(entityName: "FavoriteProduct")
        if let result = try? managedObjectContext.fetch(fetchRequest) {
            for object in result {
                managedObjectContext.delete(object)
            }
        }
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func saveAddress(address:AddressCellViewModel){
        
        if checkAddressBeforeInsert(address: address){
            print("address updated")
        }else{
        
        let managedObjectContext = persistentContainer.viewContext
        let entity               = NSEntityDescription.entity(forEntityName: "Address", in: managedObjectContext)!
        let addressToSave        = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        
        addressToSave.setValue(address.address, forKey: "address")
        addressToSave.setValue(address.isDefault, forKey: "isDefault")
        addressToSave.setValue(address.addressTitle, forKey: "name")
        addressToSave.setValue(address.owner, forKey: "owner")
        addressToSave.setValue(address.phoneNumber, forKey: "phoneNumber")
        addressToSave.setValue(address.cityCountry, forKey: "cityCountry")

        

        do{
            try managedObjectContext.save()
            print("new address saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        }
    }
    
    private func getAllOfAddressNSManageObjectArr(completion:@escaping((Result<[NSManagedObject],ErrorMessages>)->Void)){
        var objects = [NSManagedObject]()
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Address")
        do{
            objects = try managedObjectContext.fetch(fetchRequest)
            completion(.success(objects))
        }catch let error as NSError {
            print("Could not retrive data . \(error), \(error.userInfo)")
            completion(.failure(.errorRetivingFromCoreData))
        }
    }
    
    func getAllAddressWithArray( completion: @escaping ((Result<[AddressCellViewModel], ErrorMessages>)->Void)){
        var arrOfAddress = [AddressCellViewModel]()
        
        getAllOfAddressNSManageObjectArr { result in
            switch result{
            case .success(let arr):
                for item in arr{
                    let address = AddressCellViewModel(addressTitle: item.value(forKey: "name") as! String, owner: item.value(forKey: "owner") as! String, phoneNumber: item.value(forKey: "phoneNumber") as! String, cityCountry: item.value(forKey: "cityCountry") as! String, address: item.value(forKey: "address") as! String, isDefault: item.value(forKey: "isDefault") as! String)
                    arrOfAddress.append(address)
                }
                completion(.success(arrOfAddress))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
        
    }
    
    
    func checkAddressBeforeInsert(address: AddressCellViewModel)->Bool{
        var success = false
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Address")
        fetchRequest.predicate = NSPredicate(format: "isDefault == %@", address.isDefault)
        do{
           let objects = try managedObjectContext.fetch(fetchRequest)
            if objects.count == 1 {
                let addressUpdate = objects[0]
                addressUpdate.setValue(address.address, forKey: "address")
                addressUpdate.setValue(address.isDefault, forKey: "isDefault")
                addressUpdate.setValue(address.addressTitle, forKey: "name")
                addressUpdate.setValue(address.owner, forKey: "owner")
                addressUpdate.setValue(address.phoneNumber, forKey: "phoneNumber")
                addressUpdate.setValue(address.cityCountry, forKey: "cityCountry")
                
                }
                self.saveContext()
                success = true
            }

        catch let error as NSError {
            print("Could not retrive data . \(error), \(error.userInfo)")
            success = false
        }
        return success
    }
   
    
}
