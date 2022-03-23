//
//  Client.swift
//  eShtry
//
//  Created by Najeh on 17/03/2022.
//

import Foundation
import MobileBuySDK
class Client {
    
    static let shopDomain = "ahmadmazen-5960.myshopify.com"
    static let apiKey     = "bfd9f805292dbaac8c7dbc71866ca7d7"
    
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
    
    func fetchBrandProducts(vendor:String , completion:@escaping ([Storefront.Product]?) -> Void) -> Task {
        let query = ClientQuery.queryToGetBrandProducts(vendor: vendor)
        let task = client.queryGraphWith(query) { response, error in
            if let response = response {
                let products = response.products.edges.map { $0.node}
                print(products)
                completion(products)
            } else {
                completion(nil)
                print("Query failed: \(error?.localizedDescription)")
            }
        }
        task.resume()
        return task
    }
    
    func fetchAllProducts(completion: @escaping ([Storefront.Product]?)->Void) -> Task {
        let query = ClientQuery.getAllProducts()
        let task = client.queryGraphWith(query) {response, error in
            if let response = response {
                let products = response.products.edges.map { $0.node }
                completion(products)
            }else{
                completion(nil)
                print("Query Failed to get all products")
            }
        }
        task.resume()
        return task
    }
    
    func fetchProductDetails(title:String,completion: @escaping ([Storefront.Product]?) -> Void) -> Task{
        
        let query = ClientQuery.getProductDetails(title:title)
        let task = client.queryGraphWith(query) { response ,error in
            if let response = response {
                let product = response.products.edges.map {$0.node}
                print(product)
                print("--")
                completion(product)
            }
            else{
                completion(nil)
                print("Unable to fetch product")
            }
        }
        task.resume()
        return task
    }
}
