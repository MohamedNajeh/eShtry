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
    
    
    func insert(product: Products){
        let managedObjectContext = persistentContainer.viewContext
        let entity          = NSEntityDescription.entity(forEntityName: "FavoriteProduct", in: managedObjectContext)!
        let favoriteProduct = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        
        favoriteProduct.setValue("\(product.id ?? 0)", forKey: "id")
        favoriteProduct.setValue(product.title, forKey: "name")
        favoriteProduct.setValue(product.image?.src, forKey: "imageUrl")
        do{
            try managedObjectContext.save()
            print("new product saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }
    
    func insertCartItem(cartItem: CartItem){
        let managedObjectContext = persistentContainer.viewContext
        let entity           = NSEntityDescription.entity(forEntityName: "Cart", in: managedObjectContext)!
        let cartItemCoreData = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        
        cartItemCoreData.setValue(cartItem.name, forKey: "name")
        cartItemCoreData.setValue(cartItem.imgUrl, forKey: "imgUrl")
        cartItemCoreData.setValue(cartItem.price, forKey: "price")

        

        do{
            try managedObjectContext.save()
            print("new product saved")
            updateOrderArr()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }
    
    func saveOrderArrToCoreData(cartItemArr: [CartItem]){
        for cartItem in cartItemArr{
            insertCartItem(cartItem: cartItem)
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
                    let cartItem = CartItem(name: item.value(forKey: "name") as! String, price: item.value(forKey: "price") as! String, imgUrl: item.value(forKey: "imgUrl") as! String )
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
    
}
