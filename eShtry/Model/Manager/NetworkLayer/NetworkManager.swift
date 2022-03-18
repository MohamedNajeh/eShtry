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
    
    static let orderUpdatedNotification = Notification.Name("orderUpdated")

    static let shared = NetworkManager()
    private init(){}
    
    
    var order = [Orders]() {
        didSet {
            NotificationCenter.default.post(name:NetworkManager.orderUpdatedNotification,object:nil)
        }
    }
    
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
    
//    func login(email: String, password: String, completion: @escaping (DataResponse<LoginResponse, AFError>) -> ()){
//        AF.request(URL(string: "https://f36da23eb91a2fd4cba11b9a30ff124f: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@jets-ismailia.myshopify.com/admin/api/2022-01/customers.json")).validate().responseDecodable(of:LoginResponse.self) { (response) in
//            completion(response)
//        }
//    }
    
    func registerCustomer(newCustomer:CustomarRoot, completion:@escaping (Data?, URLResponse? , Error?)->()){
        guard let url = URL(string: "https://f36da23eb91a2fd4cba11b9a30ff124f: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@jets-ismailia.myshopify.com/admin/api/2022-01/customers.json") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newCustomer.asDictionary(), options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
            
        }.resume()
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
        
        urlRequest.httpShouldHandleCookies = false
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        urlRequest.httpBody = jsonData
        
        print(url)
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
