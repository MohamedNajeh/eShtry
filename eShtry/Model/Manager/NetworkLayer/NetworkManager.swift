//
//  NetworkManager.swift
//  eShtry
//
//  Created by eslam mohamed on 15/03/2022.
//

import Foundation

protocol INetworkManager{
    func getDataFromApi<B:Codable>(urlString: String,baseModel: B.Type ,completion: @escaping (Result<B,ErrorMessages>)->Void )
    
}

class NetworkManager:INetworkManager{
    
    
    static let shared = NetworkManager()
    private init(){}
    
    func getDataFromApi<B:Codable>(urlString: String,baseModel: B.Type ,completion: @escaping (Result<B,ErrorMessages>)->Void ){
        guard let url = URL(string: urlString) else{
            completion(.failure(.invalidUrl))
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                //                print("response \(response)")
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let resultData = try decoder.decode(B.self, from: data)
                completion(.success(resultData))
                //                print(resultData)
                
            }catch{
                print(error.localizedDescription)
                completion(.failure(.invalidDataAfterDecoding))
                
            }
        }
        task.resume()
        
        
    }
    
    
    
    func postDataToApi<B:Codable>(urlString: String,httpMethod:httpMethod,body:[String: Any],baseModel: B.Type ,completion: @escaping (Result<B,ErrorMessages>)->Void ){
        guard let url = URL(string: urlString) else{
            completion(.failure(.invalidUrl))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration .default)
        
        urlRequest.httpMethod = httpMethod.rawValue
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        urlRequest.httpBody = jsonData
        
        print(body)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let _ = error {
                completion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                //                print("response \(response)")
                return
            }
            print(response)
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            print(data )
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let resultData = try decoder.decode(B.self, from: data)
                completion(.success(resultData))
                //                print(resultData)
                
            }catch{
                print(error.localizedDescription)
                completion(.failure(.invalidDataAfterDecoding))
                
            }
        }
        task.resume()
        
        
    }
    
    
    
}
