//
//  Client.swift
//  eShtry
//
//  Created by Najeh on 17/03/2022.
//

import Foundation
import MobileBuySDK
class Client {
    
    static let shopDomain = "jets-ismailia.myshopify.com"
    static let apiKey     = "70adb96961fe55ab1ce308476d536e01"
    
    static let shared = Client()
    let client:Graph.Client = Graph.Client(shopDomain: shopDomain, apiKey: apiKey)
    
    
    func fetchAllCollections(completion: @escaping ([Storefront.Collection]?) -> Void) -> Task{
        let query = ClientQuery.queryToGetAllCollections()
        let task = client.queryGraphWith(query) { response, error in
         let collection = response?.collections.edges.map { $0.node }
            
            guard let result = collection else {
                completion(nil)
                print("No response")
                return
            }
            completion(result)
        }
        task.resume()
        return task
    }
    
    func fetchAllSubCategoryProducts(vendor:String , type:String , completion: @escaping ([Storefront.Product]?) -> Void) -> Task {
        let query = ClientQuery.getSubCategoryProductsQuery(vendor: vendor, type: type)
        let task = client.queryGraphWith(query) { response, error in
            let products  = response?.products.edges.map { $0.node }
            
            guard let result = products else{
                completion(nil)
                return
            }
            completion(result)
        }
        task.resume()
        return task
    }
    
    
}
