//
//  ProductsRoot.swift
//  eShtry
//
//  Created by eslam mohamed on 15/03/2022.
//

import Foundation

struct ProductsRoot: Codable{
    
    let products : [Products]?

    enum CodingKeys: String, CodingKey {

        case products = "products"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent([Products].self, forKey: .products)
    }

}
