//
//  OrdersRoot.swift
//  eShtry
//
//  Created by eslam mohamed on 16/03/2022.
//

import Foundation

struct OrdersRoot:Codable{
    
    
    let orders : [Orders]?
    
    enum CodingKeys: String, CodingKey {
        
        case orders = "orders"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orders = try values.decodeIfPresent([Orders].self, forKey: .orders)
    }
    
}
