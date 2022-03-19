//
//  NetworkReachibility.swift
//  eShtry
//
//  Created by eslam mohamed on 18/03/2022.
//

import Foundation
import Reachability

class NetworkReachibility{
    let reachability = try? Reachability()
    
    static let shared = NetworkReachibility()
    private init(){}
    
    func checkNetwork(){
        
        guard let reachability = reachability else{return}
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                
            }else{
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
}
