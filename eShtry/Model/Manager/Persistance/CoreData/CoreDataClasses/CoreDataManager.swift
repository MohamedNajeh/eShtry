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

        print("new product saved")
        do{
            try managedObjectContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
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
    
}
